const archisUrl = 'https://services3.arcgis.com/fp1tibNcN9mbExhG/arcgis/rest/services/Fiji_Sponges_Algae/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson'
const baseUrl = 'http://localhost:3000/v1/'

const SET_ARCHIS_DATA = 'SET_ARCHIS_DATA'
const SET_SPECIES_BY_LOCATION = 'SET_SPECIES_BY_LOCATION'
const SET_LOCATIONS_BY_SPECIES = 'SET_LOCATIONS_BY_SPECIES'

const state = () => ({
  archisData: null,
  speciesByLocation: [],
  locationsBySpecies: []
})

const mutations = {
  [SET_ARCHIS_DATA] (state, data) {
    state.archisData = data
  },
  [SET_SPECIES_BY_LOCATION] (state, data) {
    state.speciesByLocation = data
  },
  [SET_LOCATIONS_BY_SPECIES] (state, data) {
    state.locationsBySpecies = data
  }
}

const actions = {
  async getArchisData ({ commit }) {
    const response = await this.$axios.get(archisUrl)
    commit('SET_ARCHIS_DATA', response.data)
  },
  async getSpeciesByLocation ({ commit }, location) {
    const response = await this.$axios.get(
        `${baseUrl}/species/by_location?latitude=${location.lat}&longitude=${location.lng}`
    )
    commit('SET_SPECIES_BY_LOCATION', response.data)
  },
  async getLocationsBySpecies ({ commit }, scientificNameId) {
    const response = await this.$axios.get(
        `${baseUrl}/species/by_scientific_name_id?scientific_name_id=${scientificNameId}`
    )
    commit('SET_LOCATIONS_BY_SPECIES', response.data)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
