class Notifier < ActionMailer::Base
  
    default :from => APP_CONFIG['default_email']
        
    def welcome(toy)
      # Configure Postmark 
      postmark_settings[:api_key] = APP_CONFIG['postmark_api_key']
      smtp_settings[:user_name] = APP_CONFIG['postmark_api_key']
      smtp_settings[:password] = APP_CONFIG['postmark_api_key']
      
  	  @url = activation_url(toy.activation_token)
      mail(:to => toy.contact,
  		  :subject => 'Bienvenido a Juguetea',
  		  :date => Time.now,
  		  :tag => 'activation')      
    end
    
    def thanks(toy)   
      # Configure Postmark 
      postmark_settings[:api_key] = APP_CONFIG['postmark_api_key']
      smtp_settings[:user_name] = APP_CONFIG['postmark_api_key']
      smtp_settings[:password] = APP_CONFIG['postmark_api_key']
      
	    @url = activation_url(toy.activation_token)
      mail(:to => toy.contact,
		    :subject => 'Gracias por compartir tu juguete',
		    :date => Time.now,
		    :tag => 'activation')
      end
    
    def contact(toy, contact)
      # Configure Postmark 
      postmark_settings[:api_key] = APP_CONFIG['postmark_api_key']
      smtp_settings[:user_name] = APP_CONFIG['postmark_api_key']
      smtp_settings[:password] = APP_CONFIG['postmark_api_key']
            
      @contact = contact
      @title = toy.title
      @url = cancelation_url(toy.cancelation_token)
      mail(:to => toy.contact,
		    :subject => "Alguien esta interesado en tu juguete",
		    :date => Time.now,
		    :tag => 'contact')
    end
  
end
