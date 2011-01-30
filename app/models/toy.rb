require 'active_support'

class Toy < ActiveRecord::Base
  
  has_many :contacts
    
  before_create :generate_tokens
      
  has_attached_file :thumb, :styles => { :large => ["438x438!", :png], :medium => ["198x198!", :png], :small => ["98x98!", :png] }
  
  validates :title,  :presence => true, :length => { :maximum => 40 }
  validates :description, :presence => true, :length => { :maximum => 255 }
  validates :thumb_file_name, :presence => true  
  validates :contact, :email_pattern => true, :length => { :maximum => 40 }
  
  #Para paginar, definimos resultados/pagina
  def self.per_page
      16
  end
    
  def self.list_toys(page)
      paginate :page => page, :conditions => ["activation_token IS NULL and cancelation_token is not null"], :order => 'updated_at DESC'
  end  
  
  def self.search_by_activation_token(token)
    where("activation_token = ?", token).first
  end
  
  def self.search_by_cancelation_token(token)
    where("cancelation_token = ?", token).first
  end  
  
  def self.list_last_toys
      where("activation_token is null and cancelation_token is not null").order('updated_at DESC').limit(8)
    end  
  
  def self.list_rest_toys(toy)
    Toy.where("contact = ? and activation_token is null and cancelation_token is not null", toy.contact).reject{|t| t.id == toy.id}
  end
  
  def self.get_toy(id)
    Toy.where("id = ? and activation_token is null and cancelation_token is not null", id).first
  end
  
  private
  
  def generate_tokens
    self.activation_token = ActiveSupport::SecureRandom.base64(25).gsub("/","_").gsub(/=+$/,"")
    self.cancelation_token = ActiveSupport::SecureRandom.base64(25).gsub("/","_").gsub(/=+$/,"")
  end     
      
end
