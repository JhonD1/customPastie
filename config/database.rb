require 'sequel'
require 'dotenv'
Dotenv.load

DB = Sequel.connect(ENV['DATABASE_URL'], port: 5433, password: 'monoLit1')