require 'tty-prompt'
require '../helpers/provider_helper'

$prompt = TTY::Prompt.new

class ServicesController
  def add
    name = $prompt.ask('Service Name:')
    price = $prompt.ask('Service Price:')
    length = $prompt.ask('Service Length (Mins):')
    loop do
      provider_name = $prompt.ask('Add to which provider?:')
      sp = find_provider_by_name(provider_name)
      if sp
        sp.serviceAdd(Service.new(name, price, length))
        #successPrint()
        break
      else
        ServiceHelper.new.error_message
      end
    end
  end
end