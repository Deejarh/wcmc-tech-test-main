<template>
  <div>
    <BaseMapboxMap
      v-bind="{ configuration }"
      ref="mapboxMap"
      class="ct-map"
      @open-modal="openModal"
    />
    <Modal
      v-if="showModal"
      :show="showModal"
      :current-location="currentLocation"
      @change="closeModal"
    />
  </div>
</template>

<script>
import Modal from './Modal.vue'

const MAP_ZOOM_DEFAULT = 6

export default {
  components: { Modal },
  data () {
    return {
      configuration: {},
      showModal: false,
      currentLocation: null
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
    openModal (location) {
      this.currentLocation = { ...location }
      this.showModal = true
    },
    closeModal () {
      this.showModal = false
    }
  }
}
</script>

<style lang="postcss" scoped>
.ct-map {
  @apply h-full;
}
</style>
