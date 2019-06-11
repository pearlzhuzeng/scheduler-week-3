require 'tty-prompt'
require_relative '../helpers/service_helper'
require_relative '../helpers/utility_helper'
require_relative '../models/service'
require_relative '../models/provider'

class ServicesController
  def self.index(*args)
    puts "Here's the current list of services:"
    
    Service.all.map do |service|
      puts "#{service.name} costs $#{service.price}, and takes about #{service.length} minutes."
      puts "––––––––––"
    end
  end

  def self.add(*args)
    name = PromptInputStrategy.new.ask('Service Name:')
    price = PromptInputStrategy.new.ask('Service Price:')
    length = PromptInputStrategy.new.ask('Service Length (Mins):')
    
    loop do
      provider_name = PromptInputStrategy.new.ask('Add to which provider?:')
      provider = Provider.find_provider_by_name(provider_name)
      if provider
        service = Service.new(name, price, length)
        provider.add_service(service)
        UtilityHelper.new.notify_success
        break
      else
        ServiceHelper.new.error_message
      end
    end
  end

  def self.remove(*args)
    puts "Choose Service to Remove"
    UtilityHelper.new.print_provider_services(Provider.all)
    service_name = PromptInputStrategy.new.ask('Service Name:')
    provider_name = PromptInputStrategy.new.ask('Service Provider:')
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
end