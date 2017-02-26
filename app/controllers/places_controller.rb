require 'beermapping_api'

class PlacesController < ApplicationController
  def index
  end

  def show
    @place = BeermappingApi.place_in(session['last_city'], params[:id])
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherService.weather_for(:city)
    session['last_city'] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def google_key
    raise "GOOGLEKEY env variable not defined" if ENV['GOOGLEKEY'].nil?
    ENV['GOOGLEKEY']
  end
end