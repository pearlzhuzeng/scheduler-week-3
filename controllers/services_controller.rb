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
    
    loop do
      provider_name = $input_strategy.ask('Add to which provider?:')
      provider = Provider.find_provider_by_name(provider_name)
      if provider
        service = Service.new(name, price, length)
        provider.add_service(service)
        puts(Service.find_service_by_name(name))
        UtilityHelper.new.notify_success
        break
      else
        ServiceHelper.new.error_message
      end
    end
  end

  def self.remove
    puts "Choose Service to Remove"
    UtilityHelper.new.print_provider_services(Provider.all)
    service_name = $input_strategy.ask('Service Name:')
    provider_name = $input_strategy.ask('Service Provider:')
    provider_to_remove_from = nil
    is_found = false
    provider = Provider.all.select do |provider|
      if provider.name == provider_name
        provider_to_remove_from = provider
        is_found = true
        break      
      end
    end
    if is_found
      provider_to_remove_from.remove_service(service_name)
      UtilityHelper.new.notify_success
    else
      ServiceHelper.new.error_message
    end
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