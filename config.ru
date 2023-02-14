require 'roda'
require_relative 'app.rb'
require_relative 'models/message'

run App.freeze.app