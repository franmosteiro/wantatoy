class Location
  include ActiveModel::Validations
  attr_accessor :city, :state, :country
  
  STATES = {:AL => 'Andalucia', :PV => 'Pais Vasco',  :CT => 'Catalunia', 
            :CL => 'Castilla y Leon', :EX => 'Extremadura', :CN => 'Canarias',
            :CM => 'Castilla La Mancha', :GA => 'Galicia'}    
 
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true, :inclusion => %w(ES)
  
  def initialize(city, state, country)
    @city = city
    @state = state
    @country = country
  end
  
  def to_s
    if (@state)
      "#{@city}#{',' unless @state.nil?} #{STATES[@state.to_sym] or @state}"
    else
      "#{@city}"
    end
  end

end