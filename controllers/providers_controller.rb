require 'tty-prompt'
require_relative '../models/provider'

require_relative '../helpers/provider_helper'
require_relative '../helpers/utility_helper'

$prompt = TTY::Prompt.new

class ProvidersController
  def initialize(input_strategy)
    @input_strategy = input_strategy
  end

  def add
    name = @input_strategy.prompt('Provider Name:')
    phone = @input_strategy.prompt('Provider Phone Number:')
    $all_providers.push(Provider.new(name, phone, [], {}, []))
    UtilityHelper.new.notify_success
  end
  
  def remove
    name = @input_strategy.prompt('Provider Name To Remove:')
    $all_providers.each do |provider|
      if provider.name == name
        puts "Deleting #{name}"
        confirm = UtilityHelper.new.yes_or_no
        if confirm
          $all_providers.delete(provider)
          UtilityHelper.new.notify_success
        else
          puts 'Did Not Delete'
        end
      end
    end
  end
end