include Geokit::Geocoders

class LocationController < ApplicationController
  
  STATES = {:AL => 'Andalucia', :PV => 'Pais Vasco',  :CT => 'Catalunia', 
            :CL => 'Castilla y Leon', :EX => 'Extremadura', :CN => 'Canarias',
            :CM => 'Castilla La Mancha', :GA => 'Galicia'}
  
  def edit
    if (request.method.eql? 'POST')
      # TODO Habría que quitar las palabras España, Spain, Espagne...del parámetro de entrada
      @location = MultiGeocoder.geocode("#{params[:location]}, ES")
      if (@location.success)
        logger.info "***LOCATION:#{@location}"
        if (@location.city.blank? or @location.country_code != 'ES')
          logger.info "***PA MI QUE NO ES SPAIN"
          #errors.add(:not_spain, "This is not Spain")
          @location = params[:location]
        elsif
          # TODO Muchas veces realiza la localización por aproximación, es decir,
          # localiza un pueblo más importante cerca y toma su nombre. 
          # Es posible entonces que la ciudad localizada no coincida con lo que
          # introducido el usuario. Habría que mostar un mensaje tipo "Estas cerca de..."
          # o incluir lo que el usuario ha introducido en la localización.
          session[:geo_location] = @location
          @location = "#{session[:geo_location].city}, #{session[:geo_location].state}"
          redirect_to :controller => 'toys', :action =>'index'          
        end        
      elsif
        #errors.add(:fail, "Localization failed")
        @location = params[:location]
      end
    elsif
      @location = "#{session[:geo_location].city}, #{session[:geo_location].state}"      
    end
  end
  
end
