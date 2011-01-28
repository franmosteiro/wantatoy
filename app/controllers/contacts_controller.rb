class ContactsController < ApplicationController
  
  before_filter :load_toy

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = @toy.contacts.new(params[:contact])
    if @contact.save
      contact_mail(@toy, @contact.email)
      redirect_to(@toy, :notice => t('notice.new_contact_added'))
    else
      @rest_toys = Toy.rest_toys(@toy)
      render :action => 'toys/show'
    end
  end
  
  private
  
  def load_toy
    @toy = Toy.get_toy(params[:id])
  end
  
  def contact_mail(toy, contact)
    Notifier.contact(toy, contact).deliver()
  end

end
