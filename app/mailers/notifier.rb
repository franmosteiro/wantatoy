class Notifier < ActionMailer::Base
  
    default :from => 'thewantatoyteam@gmail.com'
    
    def thanks(toy, host, port, path)   
      @url = "http://#{host}:#{unless port == 80 then port end}#{path}/activation/#{toy.activation_token}"
      mail(:to => toy.contact)
    end
    
    def contact(toy, contact)
      @contact = contact
      @title = toy.title
      mail(:to => toy.contact)
    end
  
end
