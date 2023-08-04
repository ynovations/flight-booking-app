class FlightsController < ApplicationController

  def index
    @airports = Airport.all
    @Flight = Flight.all
    
    if request.xhr?
      # Filter flights based on the selected departure airport
      if params[:departure_airport_id].present?
        departure_airport = Airport.find(params[:departure_airport_id])
        @flights = @flights.where(departure_airport: departure_airport)
      end

      # Filter flights based on the selected arrival airport
      if params[:arrival_airport_id].present?
        arrival_airport = Airport.find(params[:arrival_airport_id])
        @flights = @flights.where(arrival_airport: arrival_airport)
      end

      # Filter flights based on the selected flight date
      if params[:flight_date].present?
        selected_date = Date.parse(params[:flight_date])
        @flights = @flights.where(flight_date: selected_date)
      end

      # Filter flights based on the selected number of passengers (1-4)
      if params[:num_passengers].present?
        num_passengers = params[:num_passengers].to_i
        @flights = @flights.where(num_passengers: num_passengers)
      end

      render turbo_stream: turbo_stream.replace("flight-results", partial: "flights/flight_results")
    end

  end

  private

  def search_flights
    if params[:departure_airport_id].present? && params[:arrival_airport_id].present?
      Flight.where(departure_airport_id: params[:departure_airport_id], arrival_airport_id: params[:arrival_airport_id])
      flights_url
    else
      [] # Return an empty array
    end

    query = Flight.all

    if params[:departure_airport_id].present?
      query = query.where(departure_airport_id: params[:departure_airport_id])
    end

    if params[:arrival_airport_id].present?
      query = query.where(arrival_airport_id: params[:arrival_airport_id])
    end

    if params[:num_passengers].present?
      query = query.where(num_passengers: params[:num_passengers])
    end

    if params[:flight_date].present?
      query = query.where(flight_date: params[:flight_date])
    end

    query

  end

  helper_method :date_dropdown_options

  def date_dropdown_options
    Flight.where.not(flight_date: nil).pluck(:flight_date).uniq.map { |date| [date.strftime('%Y-%m-%d'), date] }
  end


end
