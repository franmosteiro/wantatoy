class ToysController < ApplicationController
      
  # GET /toys
  # GET /toys.xml
  def index    
    session[:page] = params[:page] || 1
    @toys = Toy.list_toys(session[:page], session[:geo_location].lat, session[:geo_location].lng)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toys }
    end
  end

  # GET /toys/1
  # GET /toys/1.xml
  def show      
    @toy = Toy.get_toy(params[:id])
    if @toy
      @contact = @toy.contacts.new
      @rest_toys = Toy.list_rest_toys(@toy, session[:geo_location].lat, session[:geo_location].lng)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @toy }
      end
    else 
      redirect_to :action => 'index'
    end
  end

  # GET /toys/new
  # GET /toys/new.xml
  def new
    @toy = Toy.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @toy }
    end
  end

  # POST /toys
  # POST /toys.xml
  def create
    @toy = Toy.create(params[:toy])    
    @toy.lat = session[:geo_location].lat
    @toy.lng = session[:geo_location].lng
    @toy.location = session[:geo_location].city
    @toy.state = "#{Location::STATES[session[:geo_location].state.to_sym] or session[:geo_location].state}"
    respond_to do |format|
      if (@toy.save)
        if (Toy.list_rest_toys(@toy, session[:geo_location].lat, session[:geo_location].lng).size == 0) 
          Notifier.welcome(@toy).deliver()
        else
          Notifier.thanks(@toy).deliver()
        end
        flash[:title] = t('notice.new_toy_added.title')
        flash[:desc] = t('notice.new_toy_added.description') 
        format.html { redirect_to :thanks}
        format.xml  { render :xml => @toy, :status => :created, :location => @toy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @toy.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def activation
    toy = Toy.search_by_activation_token(params[:token])
    if (toy)
      toy.activation_token = nil
      toy.save
      post_tweet(toy)
      flash[:title] = t('notice.toy_activated.title')
      flash[:desc] = t('notice.toy_activated.description')
      render :action => "message"
    else
      redirect_to :action => 'index'
    end
  end
  
  def cancelation
    toy = Toy.search_by_cancelation_token(params[:token])
    if (toy)
      toy.cancelation_token = nil
      toy.save
      flash[:title] = t('notice.toy_canceled.title')
      flash[:desc] = t('notice.toy_canceled.description')
      render :action => "message"      
    else
      redirect_to :action => 'index'
    end
  end
  
  def message
    if (flash[:title].nil?) then redirect_to :action => 'index' end
  end  
      
  private
          
  def post_tweet(toy)
    # El tweet solo se pública en producción
    if (ENV['RAILS_ENV'] == 'production')
      # Initialize your Twitter client
      Twitter.configure do |config|
        config.consumer_key = APP_CONFIG['twitter_consumer_key']
        config.consumer_secret = APP_CONFIG['twitter_consumer_secret']
        config.oauth_token = APP_CONFIG['twitter_oauth_token']
        config.oauth_token_secret = APP_CONFIG['twitter_oauth_token_secret']
      end
      client = Twitter::Client.new
      # Post a tweet ;)
      client.update("#{toy.title} en #{toy.location}, #{toy.state} http://#{request.host}/toys/#{toy.permalink} #juguetea #juguetes #gratis")
    end
  end  
         
end
