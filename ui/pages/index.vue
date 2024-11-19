<template>
  <div class="ct-page">
    <div class="ct-page__map">
      <ClientOnly>
        <StatefulMap />
      </ClientOnly>
    </div>
  </div>
</template>

<script>

export default {
  name: 'PagesIndex',

  async asyncData ({ store, $axios }) {
    // fetch information from the api
    const url = 'https://services3.arcgis.com/fp1tibNcN9mbExhG/arcgis/rest/services/Fiji_Sponges_Algae/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson'
    try {
      const response = await $axios.get(url)
      await store.dispatch('map/setArchisData', response.data)
    } catch (error) {
      // console.error('Error fetching ArcGis data', error)
    }
  }
}
</script>

<style lang="postcss" scoped>
.ct-page {
  @apply h-full;

  &__map {
    @apply p-4;
  }
}
</style>
