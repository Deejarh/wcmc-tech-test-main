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
        data: this.archisData
      })
    },
    addLayer () {
      this.map.addLayer({
        id: 'arcgis-layer',
        type: 'circle',
        source: 'arcgis-data',
        paint: {
          'circle-radius': 6,
          'circle-stroke-width': 2,
          'circle-color': 'green',
          'circle-stroke-color': 'white'
        }

      })
    },
    addEventListeners () {
      this.map.on('click', 'arcgis-layer', (event) => {
        const features = this.map.queryRenderedFeatures(event.point, {
          layers: ['arcgis-layer']
        })
        /* If it does not exist, return */
        if (features.length) {
          const selectedFeature = features
          this.$emit('open-modal', selectedFeature)
        }
      })
      this.map.on('mouseenter', 'arcgis-layer', () => {
        this.map.getCanvas().style.cursor = 'pointer'
      })
      this.map.on('mouseleave', 'arcgis-layer', () => {
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
