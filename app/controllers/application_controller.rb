class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_location
  
  private 
  
  def set_location
    #session[:geo_location] = MultiGeocoder.geocode(request.remote_ip) unless session[:geo_location]
    session[:geo_location] = MultiGeocoder.geocode('77.224.233.165') unless session[:geo_location]
  end
end
