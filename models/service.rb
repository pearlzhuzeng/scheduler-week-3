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

  def save
    self.class.all << self
  end

  def print_details
    puts "#{Cyan}#{@name}#{Reset}, #{Green}$#{@price}#{Reset}, #{Yellow}#{@length} Minutes#{Reset}"
  end
end