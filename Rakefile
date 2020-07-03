require_relative "config/application"

namespace :db do
  desc "Seed development database"
  task seed: :environment do
    cmd = "psql properties_api_development < properties.sql &> /dev/null"
    puts "Seed development database"
    exec cmd
  end
end

Rails.application.load_tasks
