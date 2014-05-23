require 'csv'
namespace :import do
  desc 'foo'
  task :items => :environment do
    CSV.foreach("tmp/teams_spl_2012.txt") do |row|
      #puts "row #{row}"
      #puts "first_name : #{row[0].strip} last_name : #{row[1].strip}"
      #Person.create!(:firstname => row[0].strip, :lastname => row[1].strip,  :created_by_id => 1, :updated_by_id => 1)

      #puts "name : #{row[0].strip}"
      #Venue.create!(:name => row[0].strip,  :created_by_id => 1, :updated_by_id => 1)

      puts "name : #{row[0].strip}"
      Team.create!(:name => row[0].strip, :address1 => "123 main",  :created_by_id => 1, :updated_by_id => 1)

    end

    puts 'done'
  end
end
