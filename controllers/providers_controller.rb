require 'tty-prompt'
require_relative '../helpers/provider_helper'
require_relative '../helpers/utility_helper'
require_relative '../models/provider'

$prompt = TTY::Prompt.new

class ProvidersController
  def add(name: nil, phone: nil)
    name ||= $prompt.ask('Provider Name:')
    phone ||= $prompt.ask('Provider Phone Number:')
    $all_providers.push(Provider.new(name, phone, [], {}, []))
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