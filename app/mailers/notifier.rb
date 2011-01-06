class Notifier < ActionMailer::Base
  
    default :from => 'thewantatoyteam@gmail.com'
    
    def thanks(toy, host, port, path)   
      logger.info "TOKEN:#{toy.activation_token}"   
      @url = "http://#{host}:#{unless port == 80 then port end}#{path}/activation/#{toy.activation_token}"
      mail(:to => toy.contact)
    end
  
end
