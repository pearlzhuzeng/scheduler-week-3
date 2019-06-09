require_relative './utility_helper'
require_relative '../models/provider'

class ServiceHelper
  def error_message
    puts ''
    puts 'Service Provider Not Found...'
    puts 'Choose from the following:'
    utilityHelper.new.print_providers(Provider.all)
  end
end

