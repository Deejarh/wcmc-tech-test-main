const SET_ARCHIS_DATA = 'SET_ARCHIS_DATA'
const state = () => ({
  archisData: null
})

const mutations = {
  [SET_ARCHIS_DATA] (state, data) {
    state.archisData = data
  }
}

const actions = {
  setArchisData ({ commit }, data) {
    commit('SET_ARCHIS_DATA', data)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
