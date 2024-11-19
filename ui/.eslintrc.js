module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parserOptions: {
    parser: '@babel/eslint-parser',
    requireConfigFile: false
  },
  extends: [
    '@nuxtjs',
    'plugin:nuxt/recommended'
  ],
  plugins: [
  ],
  // add your custom rules here
  rules: {
    'no-console': ['error', { allow: ['warn', 'error'] }],
    'vue/no-v-html': 0,
    'vue/multi-word-component-names': 0,
    'vue/no-v-text-v-html-on-component': 0
  }
}
