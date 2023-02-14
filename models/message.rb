require_relative '../config/database'
require 'sequel/model'

class Message < Sequel::Model(DB[:messages])
end