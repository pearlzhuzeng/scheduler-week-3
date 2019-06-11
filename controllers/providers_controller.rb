require_relative '../seed'
require_relative '../models/provider'
require_relative '../lib/prompt_input_strategy'
require_relative '../helpers/utility_helper'

class ProvidersController
  def self.index(*args)
    puts "Here's the current list of providers:"

    Provider.all.map do |provider|
      puts "#{provider.name}'s phone number is #{provider.phone_number}."
      puts "Services: #{provider.services.map(&:name)}"
      provider.availabilities.each_with_index.map do |availability, i|
        puts "Availability #{i + 1}: #{availability.start_time} - #{availability.end_time}"
      end
      provider.appointments.each_with_index.map do |appointment, i|
        puts "Appointment #{i + 1}:"
        puts "#{appointment.print_details}"
      end
    end
  end

  def self.add(input_strategy)
    name = input_strategy.ask('Provider Name:')
    phone = input_strategy.ask('Provider Phone Number:')
    Provider.new(name, phone, [], {}, []).save
    UtilityHelper.new.notify_success
  end
  
  def self.remove(input_strategy)
    name = input_strategy.ask('Provider Name To Remove:')
    Provider.all.each do |provider|
      if provider.name == name
        puts "Deleting #{name}"
        confirm = input_strategy.ask('(y/n):')
        if confirm == 'y'
          Provider.all.delete(provider)
          UtilityHelper.new.notify_success
        else
          puts 'Did Not Delete'
        end
      end
    end
  end

  def self.view_schedule(*args)
    puts "Choose a Service Provider to see their schedule:"
    UtilityHelper.new.print_providers(Provider.all)

    provider_name = PromptInputStrategy.new.ask('Provider Name:')

    provider_candidate = nil
    is_found = false
    provider = Provider.all.each do |provider|
      if provider.name == provider_name
        provider_candidate = provider
        is_found = true
        break      
      end
    end
    if is_found
      provider_candidate.view_schedule
    else
      ServiceHelper.new.error_message
    end
  end
end