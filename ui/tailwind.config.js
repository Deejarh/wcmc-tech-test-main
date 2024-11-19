/** @type {import('tailwindcss').Config} */

module.exports = {
  content: [
    './app.html',
    './components/**/*.{vue,js}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './nuxt.config.{js,ts}'
  ],
  theme: {
    plugins: []
  }
}
