class ContactsController < ApplicationController
  
  before_filter :load_toy

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = @toy.contacts.new(params[:contact])
    if @contact.save
      redirect_to(@toy, :notice => t('notice.new_contact_added'))
    else
      render :controller => "toy", :action => "show", :id => @toy
    end
  end
  
  private
  
  def load_toy
    @toy = @toy = Toy.find_by_id(params[:toy_id])  
  end

end
