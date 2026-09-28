# Gifting Circle Simulation (Sinatra)

Sinatra port of the Rails `gifting-circle-sim` app: a simulation of how a
"gifting circle" scheme grows round after round, showing how much the
early insiders (first 5 rounds) take away.

## Setup

Requires a local PostgreSQL server.

    bundle install
    createdb gifting_circle_sim_development
    createdb gifting_circle_sim_test

## Run

    bundle exec rake db:reset   # load the seed circle
    bundle exec rackup          # http://localhost:9292

The database is `gifting_circle_sim_<APP_ENV>` (default `development`);
set `DATABASE_URL` to point elsewhere (e.g. on Heroku). Migrations run
automatically on boot.

## Test

    bundle exec rake test
