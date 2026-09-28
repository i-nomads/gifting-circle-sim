require 'sequel'

DB = Sequel.connect(ENV.fetch('DATABASE_URL') {
  "postgres:///gifting_circle_sim_#{ENV.fetch('APP_ENV', 'development')}"
})

Sequel.extension :migration
Sequel::Migrator.run(DB, File.expand_path('db/migrate', __dir__))
