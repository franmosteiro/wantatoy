class ToysController < ApplicationController
    
  # GET /toys
  # GET /toys.xml
  def index
    @toys = Toy.search(params[:title], params[:recommended_age], params[:page] || 1)
    if (params[:title].blank?)
      params.delete(:title)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @toys }
    end
  end

  # GET /toys/1
  # GET /toys/1.xml
  def show
    @toy = Toy.find(params[:id])    
    @rest_toys = Toy.where(:contact => @toy.contact).reject{|toy| toy.id == @toy.id}
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @toy }
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
    respond_to do |format|
      if @toy.save        
        # El tweet solo se pública en producción
        if (ENV['RAILS_ENV'] == 'production')
          # Initialize your Twitter client
          # TODO Sacar la configuración de la cuenta a un fichero?
          Twitter.configure do |config|
            config.consumer_key = "7jQnUb3vA9siJvfMlWYgA"
            config.consumer_secret = "sHCGamUqXdR98qX7Cs4WGtsstlizp5GoK2QUAXaX244"
            config.oauth_token = "111562005-ByhLzzkmzQcWGWUHlFqOgXnbYffgjqW64xsJcKte"
            config.oauth_token_secret = "Q9BUNpaHxxEwZKrjoP4zcH34u1DzVgmtmUc8j1ayk"
          end
          client = Twitter::Client.new
          # Post a tweet ;)
          client.update("#{@toy.title} http://#{request.host}:#{unless request.port == 80 then request.port end}#{request.path}/#{@toy.id} #wantatoy")
        end
                        
        format.html { redirect_to @toy, :notice => 'Muchas gracias por tu juguete ;)' }
        format.xml  { render :xml => @toy, :status => :created, :location => @toy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @toy.errors, :status => :unprocessable_entity }
      end
    end
  end
          
end
