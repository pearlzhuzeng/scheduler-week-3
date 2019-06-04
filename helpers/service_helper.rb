class ServiceHelper
  def error_message
    puts ''
    puts 'Service Provider Not Found...'
    puts 'Choose from the following:'
    spPrint($all_providers)
  end
end

