class Notifier < ActionMailer::Base
  
    default :from => 'alex@11dema.com'
    
    def thanks(toy)   
	  @url = activation_url(toy.activation_token)
      mail(:to => toy.contact,
		    :subject => 'Bienvenido a Juguetea',
		    :date => Time.now,
		    :tag => 'activation')
    end
    
    def contact(toy, contact)
      @contact = contact
      @title = toy.title
      mail(:to => toy.contact,
		    :subject => "Alguien esta interesado en tu juguete",
		    :date => Time.now,
		    :tag => 'contact')
    end
  
end
