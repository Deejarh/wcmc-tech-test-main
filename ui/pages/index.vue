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
