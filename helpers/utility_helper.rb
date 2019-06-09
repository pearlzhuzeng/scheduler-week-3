require_relative '../vendors/tty/colors'
require_relative '../lib/prompt_input_strategy'

class UtilityHelper
  def notify_success
    puts 'Success!'
    puts ''
  end

  def yes_or_no
    loop do
      y_n = PromptInputStrategy.new.ask('(y/n):')
      if y_n == 'y'
        return true
      elsif y_n == 'n'
        return false
      else
        puts "Enter y or n"
      end
    end
  end

  def print_providers(providers)
    puts "#{BgMagenta}SERVICE PROVIDERS:#{Reset}"
    puts '------------------'
    providers.each do |provider|
      puts "#{Magenta}#{provider.name}#{Reset}"
    end
    puts '------------------'
    puts ''
  end
  
  def print_provider_services(providers)
    puts "#{BgCyan}SERVICES:#{Reset}"
    puts '------------------'
    for provider in providers do
      provider.print_services
    end
    puts '------------------'
    puts ''
  end
end