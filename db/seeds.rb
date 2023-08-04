# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Helper method to generate random dates within a specified range
def random_date(range_start, range_end)
  rand(range_start.to_datetime..range_end.to_datetime)
end

# Clear existing data
Airport.delete_all
Flight.delete_all

# Create airports
airport_codes = %w[SFO JFK LAX ORD ATL LHR CDG]
airport_codes.each do |code|
  Airport.create!(code: code)
end

# Create flights with flight_date
num_flights = 20
start_date = Date.today
end_date = 1.year.from_now.to_date

num_flights.times do
  departure_airport = Airport.order('RANDOM()').first
  arrival_airport = (Airport.where.not(id: departure_airport.id)).order('RANDOM()').first
  flight_duration = rand(1..8) * 60 # Random duration in minutes
  flight_date = random_date(start_date, end_date).to_date # Convert to Date object

  flight = Flight.create!(
    departure_airport: departure_airport,
    arrival_airport: arrival_airport,
    start_datetime: flight_date.to_datetime,
    flight_duration: flight_duration,
    flight_date: flight_date.to_datetime
  )
end
  