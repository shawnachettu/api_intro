require 'open-uri'
require 'json'

class ApiController < ApplicationController
  def weather_form
  end

  def weather_output
    address = URI.encode(params["address"])
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{address}"
    response = open(url).read
    parsed_response = JSON.parse(response)
    @result = parsed_response["weather"][0]["description"]
    @icon = parsed_response["weather"][0]['icon']
    @lat = parsed_response["coord"]["lat"]
    @lon = parsed_response["coord"]["lon"]
    @wind_speed = parsed_response['wind']['speed']
    deg = parsed_response['wind']['deg']
    if deg < 90
      @wind_direction = "NE"
    elsif deg < 180
      @wind_direction = "SE"
    elsif deg < 270
      @wind_direction = "SW"
    elsif deg < 360
      @wind_direction = "NW"
    end
    min_kelvin = parsed_response['main']['temp_min']
    @min_temp = (min_kelvin - 273.15)* 1.8000 + 32.00


    max_kelvin = parsed_response['main']['temp_max']
    @max_temp = (max_kelvin - 273.15)* 1.8000 + 32.00

  end
end
