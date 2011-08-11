class HomeController < ApplicationController
  
  # GET /
  # GET /latest_toys.xml
  def index    
    @toys = Toy.list_last_toys(0, session[:geo_location].lat, session[:geo_location].lng)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toys }
    end
  end

end
