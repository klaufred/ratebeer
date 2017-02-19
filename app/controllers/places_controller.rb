require 'beermapping_api'

class PlacesController < ApplicationController
  def index
  end

  def show
    @places = BeermappingApi.find_place(params[:id])
    @google = "https://www.google.com/maps/embed/v1/place?q=place_id:ChIJkQYhlscLkkYRY_fiO4S9Ts0&key=#{google_key}"
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
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