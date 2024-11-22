<template>
  <div class="ct-map">
    <div ref="map" class="ct-map__container" />
  </div>
</template>

<script>
import Mapbox from 'mapbox-gl'

export default {
  props: {
    configuration: {
      type: Object,
      default: () => ({})
    }
  },

  data () {
    return {
      loaded: false,
      map: null
    }
  },

  head () {
    return {
      link: [
        {
          rel: 'stylesheet',
          href: 'https://api.mapbox.com/mapbox-gl-js/v2.9.2/mapbox-gl.css'
        }
      ]
    }
  },

  computed: {
    archisData () {
      return this.$store.state.map.archisData
    }
  },

  mounted () {
    this.map = new Mapbox.Map({
      container: this.$refs.map,
      ...this.configuration
    })

    this.map.on('load', () => {
      this.loaded = true
      this.initializeMap()
    })
  },

  methods: {
    async initializeMap () {
      await this.addSource()
      await this.addLayer()
      this.addEventListeners()
    },
    addSource () {
      this.map.addSource('arcgis-data', {
        type: 'geojson',
        data: this.archisData,
        cluster: true,
        clusterMaxZoom: 6,
        clusterRadius: 15
      })
    },
    addLayer () {
      this.map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'arcgis-data',
        filter: ['has', 'point_count'],
        paint: {
          'circle-color': [
            'step',
            ['get', 'point_count'],
            '#808080', // color for point_count <=50
            50,
            '#808080',
            100,
            '#ff2c2c' // red color for point_count >= 100
          ],
          'circle-stroke-color': 'white',
          'circle-radius': 6,
          'circle-stroke-width': 1
        }
      })

      this.map.addLayer({
        id: 'unclustered-point',
        type: 'circle',
        source: 'arcgis-data',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-color': 'green',
          'circle-radius': 6,
          'circle-stroke-width': 1,
          'circle-stroke-color': 'white'
        }
      })
    },
    addEventListeners () {
      this.map.on('click', 'clusters', (e) => {
        const features = this.map.queryRenderedFeatures(e.point, {
          layers: ['clusters']
        })
        if (features.length > 0) {
          const clusterId = features[0].properties.cluster_id
          this.map
            .getSource('arcgis-data')
            .getClusterExpansionZoom(clusterId, (err, zoom) => {
              if (err) {
                return
              }

              this.map.easeTo({
                center: features[0].geometry.coordinates,
                zoom
              })
            })
        }
      })
      this.map.on('click', 'unclustered-point', (event) => {
        const features = this.map.queryRenderedFeatures(event.point, {
          layers: ['unclustered-point']
        })
        if (features.length) {
          const selectedFeature = features[0]
          const location = {
            lng: selectedFeature.properties.decimalLongitude,
            lat: selectedFeature.properties.decimalLatitude
          }
          this.$emit('open-modal', location)
        }
      })
      this.map.on('mouseenter', 'clusters', () => {
        this.map.getCanvas().style.cursor = 'pointer'
      })
      this.map.on('mouseleave', 'clusters', () => {
        this.map.getCanvas().style.cursor = ''
      })
      this.map.on('mouseenter', 'unclustered-point', () => {
        this.map.getCanvas().style.cursor = 'pointer'
      })
      this.map.on('mouseleave', 'unclustered-point', () => {
        this.map.getCanvas().style.cursor = ''
      })
    }
  }
}
</script>

<style lang="postcss" scoped>
.ct-map {
  height: 512px;

  &__container {
    @apply h-full;
  }
}
</style>
