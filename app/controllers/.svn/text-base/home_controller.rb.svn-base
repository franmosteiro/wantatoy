class HomeController < ApplicationController
  # GET /
  # GET /latest_toys.xml
  def index
    @toys = Toy.order("created_at desc").find(:all, :limit => 4)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toys }
    end
  end

end
