include Geokit::Geocoders

class ApplicationController < ActionController::Base
  protect_from_forgery
  geocode_ip_address
  
  before_filter :set_location
  
  def set_location
    if (ENV['RAILS_ENV'] == 'development')
      session[:geo_location] = IpGeocoder.geocode('77.224.233.165') unless session[:geo_location]
    else
      session[:geo_location] = IpGeocoder.geocode(request.remote_ip) unless session[:geo_location]
    end
  end  
  
end
