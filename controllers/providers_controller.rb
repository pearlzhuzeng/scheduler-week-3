require 'tty-prompt'
require_relative '../helpers/provider_helper'
require_relative '../helpers/utility_helper'

$prompt = TTY::Prompt.new

class ProvidersController
  def add
    provider_name = $prompt.ask('Provider Name:')
    provider_phone = $prompt.ask('Provider Phone Number:')
    $all_providers.push(Provider.new(provider_name, provider_phone, [], {}, []))
    UtilityHelper.new.notify_success
  end
  
  def remove
    provider_name = $prompt.ask('Provider Name To Remove:')
    $all_providers.each do |sp|
      if sp.name == provider_name
        puts "Deleting #{provider_name}"
        confirm = y_or_n()
        if confirm
          $all_providers.delete(sp)
          UtilityHelper.new.notify_success
        else
          puts 'Did Not Delete'
        end
      end
    end
  end
end