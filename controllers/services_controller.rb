require 'tty-prompt'
require_relative '../helpers/service_helper'
require_relative '../helpers/utility_helper'
require_relative '../models/service'
require_relative '../models/provider'

class ServicesController
  def self.index
    puts "Here's the current list of services:"
    
    Service.all.map do |service|
      puts "#{service.name} costs $#{service.price}, and takes about #{service.length} minutes."
      puts "––––––––––"
    end
  end

  def self.add
    name = add_service_name
    price = add_service_price
    length = add_service_length

    service = Service.new(name, price, length)
    service.save
    UtilityHelper.new.notify_success
  end

  def self.remove
    puts "Choose Service to Remove: "
    service_name = $input_strategy.ask('Service Name:')
    Service.all.select! { |service| service.name != service_name }
    Provider.find_provider_by_service(service_name).each do |provider|
      provider.remove_service(service_name)
    end
    UtilityHelper.new.notify_success
  end

  private

  def self.add_service_name
    loop do
      name = $input_strategy.ask('Service Name:')
      if Service.find_service_by_name(name)
        puts "This service already exists. Please enter a different service name."
      else
        return name
      end
    end
  end

  def self.add_service_price
    loop do
      price = $input_strategy.ask('Service Price:')
      if !numeric?(price)
        puts "Invalid price. Please enter a number."
      else
        return price
      end
    end
  end

  def self.add_service_length
    loop do
      length = $input_strategy.ask('Service Length (Mins):')
      if !numeric?(length)
        puts "Invalid length. Please enter a number."
      else
        return length
      end
    end
  end

  def self.numeric?(string)
    Float(string) != nil rescue false
  end
end