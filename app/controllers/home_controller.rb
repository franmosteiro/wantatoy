class HomeController < ApplicationController
  # GET /
  # GET /latest_toys.xml
  def index
    @toys = Toy.search_last_toys
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toys }
    end
  end

end
