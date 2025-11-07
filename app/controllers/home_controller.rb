class HomeController < ApplicationController
  before_action :validate_address, only: [:check_weather]
  attr_reader :zipcode


  def index
  end

  def check_weather
    if @zipcode.present?
      client = OpenWeather::Client.new(api_key: ENV['WEATHER_API_KEY'])
      @result = client.current_weather(zip: @zipcode)
    else
      flash[:error] = 'The Address entered is invalid. Please enter a valid address'
      redirect_to root_path
    end
  end

  def validate_address
    google_address = Geocoder.search(params[:input_address][:address])
    @zipcode = google_address[0].postal_code
  end
end

