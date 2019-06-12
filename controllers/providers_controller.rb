require_relative '../seed'
require_relative '../models/provider'
require_relative '../helpers/utility_helper'

class ProvidersController
  def self.index
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

  def self.add
    name = add_provider_name
    phone = add_provider_phone
    selected_services = select_services
    Provider.new(name, phone, selected_services, [], []).save
    add_availability(name)
    UtilityHelper.new.notify_success
  end
  
  def self.remove
    name = $input_strategy.ask('Provider Name To Remove:')
    Provider.all.each do |provider|
      if provider.name == name
        puts "Deleting #{name}"
        confirm = $input_strategy.ask('(y/n):')
        if confirm == 'y'
          Provider.all.delete(provider)
          UtilityHelper.new.notify_success
        else
          puts 'Did Not Delete'
        end
      end
    end
  end

  def self.view_schedule
    puts "Choose a Service Provider to see their schedule:"
    UtilityHelper.new.print_providers(Provider.all)

    provider_name = $input_strategy.ask('Provider Name:')

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

  def self.provider_exists?(name)
    provider_exists = false
    Provider.all.map do |provider|
      provider_exists = true if provider.name == name
    end
    provider_exists
  end

  def self.valid_phone?(phone)
    phone.to_i.to_s == phone && phone.length == 10
  end

  def self.add_provider_name
    valid_provider_name = false
    while !valid_provider_name
      name = $input_strategy.ask('Provider Name:')
      if self.provider_exists?(name)
        puts('This provider already exists. Please enter a different name.')
      else
        valid_provider_name = true if !self.provider_exists?(name)
      end
    end
    name
  end

  def self.add_provider_phone
    valid_phone = false
    while !valid_phone
      phone = $input_strategy.ask('Provider Phone Number:')
      if !self.valid_phone?(phone)
        puts('Please enter a valid 10-digit phone number.')
      else
        valid_phone = true
      end
    end
    phone
  end

  def self.select_services
    selected_services_names = $input_strategy.multi_select("What services does this provider offer?", 
      Service.all.map(&:name))
    selected_services = []
    selected_services_names.each do |service_name|
      service = Service.find_service_by_name(service_name)
      selected_services << service
    end
    selected_services
  end

  def self.add_availability(name)
    done_adding_availability = false
    while !done_adding_availability
      puts("What is this provider's availability?")
      AvailabilitiesController.add_to_provider(name)
      done_adding_availability = !$input_strategy.yes_or_no("Would you like to continue adding availability?")
    end
  end
end