require 'tty-prompt'
require_relative '../helpers/provider_helper'
require_relative '../helpers/utility_helper'

$prompt = TTY::Prompt.new

class ServicesController
  def add
    name = $prompt.ask('Service Name:')
    price = $prompt.ask('Service Price:')
    length = $prompt.ask('Service Length (Mins):')
    loop do
      provider_name = $prompt.ask('Add to which provider?:')
      provider = ProviderHelper.new.find_provider_by_name(provider_name)
      if sp
        provider.serviceAdd(Service.new(name, price, length))
        UtilityHelper.new.notify_success
        break
      else
        ServiceHelper.new.error_message
      end
    end
  end

  def remove
    puts "Choose Service to Remove"
    servicePrint($all_providers)
    service_name = $prompt.ask('Service Name:')
    provider_name = $prompt.ask('Service Provider:')
    providerToRemove = nil
    isFound = false
    provider = $all_providers.select do |provider|
      if provider.name == provider_name
        providerToRemove = provider
        isFound = true
        break      
      end
    end
    if isFound
      providerToRemove.serviceRemove(service_name)
      UtilityHelper.new.notify_success
    else
      ServiceHelper.new.error_message
    end
  end
end