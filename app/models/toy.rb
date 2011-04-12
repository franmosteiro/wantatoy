require 'active_support'

class Toy < ActiveRecord::Base
  
  before_create :generate_tokens
  
  has_permalink :title
  has_many :contacts    
  has_attached_file :thumb, :styles => { :large => ["438x438!", :png], :medium => ["198x198!", :png], :small => ["98x98!", :png] }
  
  validates :title,  :presence => true, :length => { :maximum => 40 }
  validates :description, :presence => true, :length => { :maximum => 255 }
  validates :contact, :email_pattern => true, :length => { :maximum => 40 }
  validates_attachment_presence :thumb
  validates_attachment_content_type :thumb, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => :not_valid
  validates_attachment_size :thumb, :less_than => 3.megabytes
  
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng  

  #Para paginar, definimos resultados/pagina
  def self.per_page
      16
  end
  
  def self.list_toys(page, lat, lng)
      Toy.within(50, :origin => [lat, lng]).where("activation_token IS NULL and cancelation_token is not null").order('updated_at DESC').paginate(:page => page, :per_page => Toy.per_page)
  end  
  
  def self.search_by_activation_token(token)
    where("activation_token = ?", token).first
  end
  
  def self.search_by_cancelation_token(token)
    where("cancelation_token = ?", token).first
  end  
  
  def self.list_last_toys(lat, lng)
    Toy.within(50, :origin => [lat, lng]).where("activation_token is null and cancelation_token is not null").order('updated_at DESC').limit(8)
  end  
  
  def self.list_rest_toys(toy, lat, lng)
    Toy.within(50, :origin => [lat, lng]).where("contact = ? and activation_token is null and cancelation_token is not null", toy.contact).reject{|t| t.id == toy.id}
  end
  
  def self.get_toy(id)
    Toy.where("permalink = ? and activation_token is null and cancelation_token is not null", id).first
  end
  
  def to_param
    permalink
  end         
  
  
  private
  
  def generate_tokens
    self.activation_token = ActiveSupport::SecureRandom.base64(25).gsub("/","_").gsub(/=+$/,"")
    self.cancelation_token = ActiveSupport::SecureRandom.base64(25).gsub("/","_").gsub(/=+$/,"")
  end     
      
end
