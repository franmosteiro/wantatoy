include Geokit::Geocoders

class LocationController < ApplicationController
  
  skip_before_filter :set_location
      
  def edit
    if (request.method.eql? 'POST')
      @geolocation = MultiGeocoder.geocode("#{params[:location]}, ES")
      if (@geolocation.success)
        @location = Location.new(@geolocation.city, @geolocation.state, @geolocation.country_code)
        if (@location.valid?)
          session[:geo_location] = @geolocation
          redirect_to :controller => 'toys', :action =>'index'                    
        else
          flash[:title] = t('notice.location_not_spain.title')
          flash[:desc] = t('notice.location_not_spain.description')           
          @location = Location.new(params[:location], nil, nil)
        end
      elsif
        @location = Location.new(params[:location], nil, nil)
        flash[:title] = t('notice.improve_location.title')
        flash[:desc] = t('notice.improve_location.description') 
      end
    elsif      
        @location = Location.new(session[:geo_location].city, session[:geo_location].state, session[:geo_location].country_code)        
        if @location.valid?
          flash[:title] = t('page_title.location')
          flash[:desc] = t('notice.improve_location.description') 
        else
          flash[:title] = t('notice.location_not_spain.title')
          flash[:desc] = t('notice.location_not_spain.description')           
        end        
    end
  end
  
end
