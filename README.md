# WCMC Tech Test

This project has a front and backend distinction that makes it differ from the
way that Rails projects are usually deployed.

It is built using Nuxt as the frontend framework (wrapped around Vue.js 2) and
Ruby on Rails (version 7) in API mode for the backend (with Ruby 3.1.0).

## Setup

1. Open a couple of terminal tabs, one for the 'ui' subdirectory
and one for the 'api' subdirectory
2. **Nuxt:** use the correct Node version - `nvm use` (if not present, install
then reinstall yarn - `nvm install && npm install -g yarn`)
3. **Rails:** install dependencies - `bundle install`
4. **Nuxt:** install dependencies - `yarn install`

The databse adapter has been setup to **PostgreSQL** as a default, but you are free
to use any adapter you prefer (SQLite, MySQL,...).

## Local use

### Server startup

1. **Rails:** start server - `bundle exec rails s`
2. **Nuxt:** start server - `yarn dev`

### Links

- **Frontend (Nuxt):** [http://localhost:8080](http://localhost:8080)
- **Tailwind config viewer:** [http://localhost:8080/_tailwind](http://localhost:8080/_tailwind/)
- **API:** [http://localhost:3000/v1](http://localhost:3000/v1) (see note below about API calls)

### Docker

Install Docker.
Try [rootless mode](https://docs.docker.com/engine/security/rootless/) if you're having issues with it.

```
docker compose build
docker compose run --rm api bin/setup
docker compose run --rm ui yarn install
docker compose up -d
```

Open http://localhost:8080 # Nuxt
Open http://localhost:3000 # Rails


## Notes

* API calls from frontend AJAX should go to `/api` which is proxied against the
`.env/RAILS_API_ENDPOINT` and should usually be something like `http://localhost:3000/v1`,
so replace the `v1` with `api` when making requests to the API
