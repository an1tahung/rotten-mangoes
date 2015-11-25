namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    (0..20).each do
      user = User.new
      user.firstname = Faker::Name.first_name
      user.password = Faker::Internet.password(6)
      user.lastname  = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.admin = false 
      user.save
    end
  end
end