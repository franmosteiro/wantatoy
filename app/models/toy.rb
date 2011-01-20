require 'active_support'

class Toy < ActiveRecord::Base
  
  has_many :contacts
  
  RECOMMENDED_AGES = ['0-6','7-12','13-18','19-24','2-3','4-5','6-8','9-11','+12']
  
  before_create :generate_token
      
  has_attached_file :thumb, :styles => { :large => ["438x438!", :png], :medium => ["198x198!", :png], :small => ["98x98!", :png] }
  
  validates :title,  :presence => true, :length => { :maximum => 40 }
  validates :description, :presence => true, :length => { :maximum => 255 }
  validates :recommended_age, :inclusion => { :in => RECOMMENDED_AGES }  
  validates :thumb_file_name, :presence => true  
  validates :contact, :email_pattern => true, :length => { :maximum => 40 }
  
  #Para paginar, definimos resultados/pagina
  def self.per_page
      12
  end
    
  def self.search(title, recommended_age, page)
    if (recommended_age.nil?)
      paginate :page => page, :conditions => ["title like ? and activation_token IS NULL", "%#{title}%"], :order => 'created_at DESC'
    else
      paginate :page => page, :conditions => ["title like ? and recommended_age = ? and activation_token IS NULL", "%#{title}%", recommended_age], :order => 'created_at DESC'
    end
  end  
  
  def self.search_by_activation_token(token)
    where("activation_token = ?", token).first
  end
  
  def self.search_last_toys
    where("activation_token IS NULL", :limit => 4)
  end
  
  private
  
  def generate_token
    self.activation_token = ActiveSupport::SecureRandom.base64(25).gsub("/","_").gsub(/=+$/,"")
  end     
      
end
