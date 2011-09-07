require 'securerandom'
require 'rails/generators/migration'

module Spleen
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Copy model and locale files to your application and generate migration."
      class_option :orm

      def copy_locale
        copy_file "locales.en.yml", "config/locales/ratings.en.yml"
      end

      def copy_model
        template "model.rb", "app/models/rating.rb"
      end

      def copy_rating_migration
        migration_template "migration.rb", "db/migrate/create_ratings"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end

      # Taken from ActiveRecord's migration generator
      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end
