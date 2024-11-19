<template>
  <BaseMapboxMap
    v-bind="{ configuration }"
    ref="mapboxMap"
    class="ct-map"
  />
</template>

<script>
const MAP_ZOOM_DEFAULT = 6

export default {
  data () {
    return {
      configuration: {}
    }
  },

  created () {
    this.configuration = {
      accessToken: this.$config.mapbox.accessToken,
      style: this.$config.mapbox.mapStyle,
      center: [178.441895, -18.141600],
      zoom: MAP_ZOOM_DEFAULT
    }
  },

  methods: {

  }
}
</script>

<style lang="postcss" scoped>
.ct-map {
  @apply h-full;
}
</style>
