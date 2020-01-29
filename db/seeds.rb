# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


more_cadets = [ {:lastName =>'Hotsko', :firstName => 'Jessica', :email => 'rotseetest@gmail.com', :phoneNumber => '1111111111', :school => 'Tulane University', :position => 'Cadet Wing Commander', :course => 'AS400', :gradYear => 2020 , :flight => 'Bravo', :username => 'jhotsko', :password => 'password', :approved => true}]
    
more_cadets.each do |cadet|
    Cadet.create!(cadet)
end
