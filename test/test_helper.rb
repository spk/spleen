# encoding: UTF-8
require 'minitest/autorun'
require 'active_record'

require File.expand_path('../../lib/spleen', __FILE__)

# If you want to see the ActiveRecord log, invoke the tests using `rake test LOG=true`
if ENV["LOG"]
  require "logger"
  ActiveRecord::Base.logger = Logger.new($stdout)
end

driver = "sqlite3"
config = YAML.load_file(File.expand_path("../databases.yml", __FILE__))
ActiveRecord::Base.establish_connection config[driver]
ActiveRecord::Migration.verbose = false

require 'generators/spleen/templates/migration'
CreateRatings.up

%w{articles users}.each do |table_name|
  ActiveRecord::Migration.create_table table_name do |t|
    t.string :name
    t.boolean :active
  end
end
