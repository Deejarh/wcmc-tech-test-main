<template>
  <div>
    <Modal
      :show="show"
      @change="closeModal"
    >
      <template #header>
        <div v-if="isLoading">
          Loadingg
        </div>
        <div v-else class=" flex justify-between  py-3">
          <div>
            <TPagination
              v-model="currentPage"
              :total-items="totalItems"
              :per-page="perPage"
              :limit="limit"
              hide-ellipsis
              hide-first-last-controls
            />
          </div>

          <nav class="flex space-x-4 ">
            <TButton
              variant="link"
              :class="{ 'font-bold': activeTab === 'byLocation' }"
              @click="setActiveTab('byLocation')"
            >
              Species
            </TButton>
            <TButton
              variant="link"
              :class="{ 'font-bold': activeTab === 'bySpecies' }"
              @click="setActiveTab('bySpecies')"
            >
              Locations
            </TButton>
          </nav>
          <h2>{{ currentPage }} of {{ totalItems }}</h2>
        </div>
      </template>
      <div v-if="activeTab === 'byLocation'" class="  overflow-scroll">
        <table
          class="w-full text-left text-xs "
        >
          <tbody>
            <tr
              v-for="(value, key, index) in currentFeature"
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

      <div v-if="activeTab === 'bySpecies'" class=" overflow-scroll">
        <table
          v-if="locationsBySpecies.length > 0"
          class="w-full text-left text-xs "
        >
          <tbody>
            <tr
              v-for="(value, key, index ) in currentFeature"
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
        <p v-else class=" text-xs">
          Error fetching species. <TButton @click="fetchLocations">
            Retry
          </TButton>
        </p>
      </div>
    </Modal>
  </div>
</template>

<script>
import { TPagination, TButton } from 'vue-tailwind/dist/components'
import Modal from '@/components/Base/Modal.vue'

export default {
  components: {
    Modal,
    TPagination,
    TButton
  },
  props: {
    show: {
      type: Boolean,
      required: true
    },
    currentLocation: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      configuration: {},
      selectedFeature: [],
      perPage: 1,
      currentPage: 1,
      limit: 0,
      activeTab: 'byLocation',
      isLoading: false
    }
  },

  computed: {
    speciesByLocation () {
      return this.$store.state.map.speciesByLocation || []
    },
    locationsBySpecies () {
      return this.$store.state.map.locationsBySpecies || []
    },
    totalItems () {
      return this.activeTab === 'bySpecies' ? this.locationsBySpecies.length : this.speciesByLocation.length
    },
    currentScientificId () {
      return this.speciesByLocation[this.currentPage - 1]?.scientific_name_id
    },
    isCurrentId () {
      return this.currentScientificId === this.locationsBySpecies[this.currentPage - 1]?.scientific_name_id
    },
    currentFeature () {
      const data =
      this.activeTab === 'bySpecies'
        ? this.locationsBySpecies
        : this.speciesByLocation
      return data[this.currentPage - 1] || {}
    }
  },
  async created () {
    await this.fetchSpecies()
  },

  methods: {
    async fetchSpecies () {
      this.isLoading = true
      if (this.currentLocation) {
        try {
          await this.$store.dispatch('map/getSpeciesByLocation', this.currentLocation)
        } catch (error) {
          this.isLoading = false
        } finally {
          this.isLoading = false
        }
      }
    },
    async fetchLocations () {
      if (!this.currentScientificId || this.isCurrentId) {
        return
      }
      this.isLoading = true
      try {
        await this.$store.dispatch('map/getLocationsBySpecies', this.currentScientificId)
      } catch (error) {
        this.isLoading = false
      } finally {
        this.isLoading = false
      }
    },
    async setActiveTab (tab) {
      this.activeTab = tab
      this.currentPage = 1
      if (tab === 'bySpecies') {
        await this.fetchLocations()
      }
    },

    closeModal () {
      this.$emit('change')
    }
  }

}
</script>
