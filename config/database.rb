require 'sequel'
require 'dotenv'
Dotenv.load

DB = Sequel.connect(ENV['DATABASE_URL'], password: ENV['DATABASE_PASS'])