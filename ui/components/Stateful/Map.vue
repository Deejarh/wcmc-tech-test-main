<template>
  <div>
    <BaseMapboxMap
      v-bind="{ configuration }"
      ref="mapboxMap"
      class="ct-map"
      @open-modal="(feature) => {
        openFeatureModal(feature);
      }"
    />
    <Modal
      :show="showModal"
      @change="closeModal"
    >
      <template #header>
        <div class=" flex justify-between border-b py-3">
          <div>
            <TPagination
              v-model="currentPage"
              :total-items="selectedFeature.length"
              :per-page="perPage"
              :limit="limit"
              hide-ellipsis
              hide-first-last-controls
            />
          </div>
          <h2>{{ currentPage }} of {{ selectedFeature.length }}</h2>
        </div>
        <div class=" flex justify-between">
          <h2 class=" text-lg font-medium">
            {{ currentFeature.properties.collectionCode || 'Feature Details' }}
          </h2>
        </div>
      </template>
      <div v-if="currentFeature.properties" class=" max-h-56 overflow-scroll">
        <table
          class="w-full text-left text-xs border-collapse"
        >
          <tbody>
            <tr
              v-for="(value, key, index) in currentFeature.properties"
              :key="index"
              :class="{
                'bg-gray-100': index % 2 === 0,
                'bg-white': index % 2 !== 0
              }"
            >
              <td class=" py-2 pl-2">
                {{ key }}
              </td>
              <td class=" py-2 pl-2 border-l border-gray-200">
                {{ value || '' }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </Modal>
  </div>
</template>

<script>
import { TPagination } from 'vue-tailwind/dist/components'
import Modal from '@/components/Base/Modal.vue'
const MAP_ZOOM_DEFAULT = 6

export default {
  components: {
    Modal,
    TPagination
  },

  data () {
    return {
      configuration: {},
      showModal: false,
      selectedFeature: [],
      perPage: 1,
      currentPage: 1,
      limit: 0
    }
  },

  computed: {
    currentFeature () {
      return this.selectedFeature[this.currentPage - 1] || {}
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
    openFeatureModal (feature) {
      this.selectedFeature = Array.isArray(feature) ? feature : [feature]
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
