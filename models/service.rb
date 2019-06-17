class Service
  attr_accessor :services
  attr_reader :name, :price, :length

  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end

  def self.all
    @services
  end

  def self.all_names
    all.map {|service| service.name}
  end

  def self.all_service_names(services_list)
    services_list.map {|service| service.name}
  end

  def save
    self.class.all << self
  end

  def self.find_service_by_name(service_name)
    service = @services.select do |service| 
      service.name == service_name
    end

    service.first
  end

  def print_details
    puts "#{Cyan}#{@name}#{Reset}, #{Green}$#{@price}#{Reset}, #{Yellow}#{@length} Minutes#{Reset}"
  end
end