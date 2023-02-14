require_relative 'database'

DB.create_table? :messages do
  primary_key :id
  String :content
  String :slug
  String :password_digest
end