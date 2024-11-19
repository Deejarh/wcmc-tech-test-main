<template>
  <div class="ct-public">
    <PortalTarget name="modal" />
    <div class="ct-public__container">
      <div class="ct-public__body">
        <Nuxt />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LayoutDefault'
}
</script>

<style lang="postcss" scoped>
html {
  @apply bg-slate-50;
}

.ct-public {
  &__container {
    @apply flex
      flex-col
      min-h-screen;
  }

  &__header {
    @apply bg-white;
  }

  &__body {
    @apply flex-1
      bg-white;
  }
}
</style>
