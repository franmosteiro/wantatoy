require 'active_support'

class Toy < ActiveRecord::Base
  
  before_create :generate_tokens
  
  has_permalink :title
  has_many :contacts    
  # Guardamos el thumb el "aws s3" sólo en producción 
  if (ENV['RAILS_ENV'] == 'production')
	  has_attached_file :thumb, 
		:styles => { 
					:large => ["438x438!", :png], 
					:medium => ["198x198!", :png], 
					:small => ["98x98!", :png] 
		},
		:storage => :s3,
		:s3_credentials => "#{::Rails.root.to_s}/config/s3.yml",
		:path => ":attachment/:style/:id/:filename"
  else
	  has_attached_file :thumb, 
		:styles => { 
					:large => ["438x438!", :png], 
					:medium => ["198x198!", :png], 
					:small => ["98x98!", :png] 
		}
  end	
  validates :title,  :presence => true, :length => { :maximum => 40 }
  validates :description, :presence => true, :length => { :maximum => 255 }
  validates :contact, :email_pattern => true, :length => { :maximum => 40 }
  validates_attachment_presence :thumb
  validates_attachment_content_type :thumb, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => :not_valid
  validates_attachment_size :thumb, :less_than => 3.megabytes
  
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
