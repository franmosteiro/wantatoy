include Geokit::Geocoders

class ApplicationController < ActionController::Base
  protect_from_forgery
  geocode_ip_address  
  
  before_filter :set_location
  
  def set_location        
    if (session[:geo_location].nil?)
      begin
        location = MultiGeocoder.geocode(request.remote_ip)
      rescue ActionDispatch::Cookies::CookieOverflow
        logger.debug "***EXCEPTION 1***"
      end
      if (location.success)
        if (location.country_code.eql? "ES")
          location = MultiGeocoder.geocode("#{location.city} #{location.state}, ES") # Para obtener lo resultados en castellano
            session[:geo_location] = location if (location.success)
        else          
          session[:geo_location] = location
          redirect_to :controller => 'location', :action => 'edit'
        end
      end            
    elsif (!session[:geo_location].country_code.eql? "ES")
      redirect_to :controller => 'location', :action => 'edit'      
    end    
  end  
  
end
