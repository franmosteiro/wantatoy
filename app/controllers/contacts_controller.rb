class ContactsController < ApplicationController
  
  before_filter :load_toy

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])    
    @contact.toy_id = @toy.id
    if @contact.save
      Notifier.contact(@toy, @contact.email).deliver()
      redirect_to(@toy, :notice => t('notice.new_contact_added'))
    else
      @rest_toys = Toy.list_rest_toys(@toy, 0, session[:geo_location].lat, session[:geo_location].lng)
      render :action => 'toys/show'
    end
  end
  
  private
  
  def load_toy
    @toy = Toy.get_toy(params[:toy_id])
  end

end
