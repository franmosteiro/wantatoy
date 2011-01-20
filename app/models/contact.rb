class Contact < ActiveRecord::Base
  
  belongs_to :toy, :dependent => :destroy
  
  validates :email, :email_pattern => true, :length => { :maximum => 40 }
  
end
