
export default {
  // @see https://nuxtjs.org/docs/configuration-glossary/configuration-server/
  server: {
    host: process.env.HOST || 'localhost',
    port: process.env.PORT || 8080
  },

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'wcmc-tech-test',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' }
    ]
  },

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    { src: '~/plugins/vueTailwind.js' }
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    '@nuxtjs/eslint-module',
    // https://go.nuxtjs.dev/stylelint
    '@nuxtjs/stylelint-module'
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    // https://github.com/LinusBorg/portal-vue
    'portal-vue/nuxt',
    // https://tailwindcss.nuxtjs.org/
    '@nuxtjs/tailwindcss'
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    proxy: true,
    headers: {
      common: {
        'Content-Type': 'application/json',
        Accept: 'application/json'
      }
    }
  },

  proxy: {
    '/api/': {
      target: process.env.RAILS_API_ENDPOINT,
      pathRewrite: { '^/api/': '' }
    }
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    postcss: {
      // Add plugin names as key and arguments as value
      // Install them before as dependencies with npm or yarn
      plugins: {
        // Disable a plugin by passing false as value
        'postcss-import': {},
        'tailwindcss/nesting': {},
        autoprefixer: {}
      }
    }
  },

  publicRuntimeConfig: {
    mapbox: {
      accessToken: process.env.MAPBOX_ACCESS_TOKEN,
      mapStyle: process.env.MAPBOX_MAP_STYLE
    },
    railsApiEndpoint: process.env.RAILS_API_ENDPOINT
  }
}
