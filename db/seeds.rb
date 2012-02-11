# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Sex.find_or_create_by_name :Man
Sex.find_or_create_by_name :Vrouw

open("db/scholen.txt") do |colleges|
  colleges.read.each_line do |college|
    College.find_or_create_by_name college.chomp
  end
end

open("db/onderdelenmannen.txt") do |events|
  events.read.each_line do |event|
    Event.find_or_create_by_name_and_sex_id(event.chomp, :sex_id => Sex.find_by_name(:Man).id)
  end
end

open("db/onderdelenvrouwen.txt") do |events|
  events.read.each_line do |event|
    Event.find_or_create_by_name_and_sex_id(event.chomp, :sex_id => Sex.find_by_name(:Vrouw).id)
  end
end

Club.find_or_create_by_name('geen')
Day.find_or_create_by_date("2012-05-16")

open("db/verenigingen.txt") do |clubs|
  clubs.read.each_line do |club|
    Club.find_or_create_by_name(club.chomp)
  end
end