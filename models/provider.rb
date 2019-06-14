require 'date'
require_relative '../models/service'
require_relative '../models/availability'
require_relative '../models/appointment'

class Provider
  attr_reader :name, :phone_number, :services, :availabilities, :appointments

  def initialize(name, phone_number, services = [], availabilities = [], appointments = [])
    @name = name
    @phone_number = phone_number
    @services = services
    @availabilities = availabilities
    @appointments = appointments
  end

  def self.all
    @providers
  end

  def save
    self.class.all << self
  end

  def self.find_provider_by_service(service_name)
    providers = []
    for provider in @providers do
      for service in provider.services do
        if service.name == service_name
          providers << provider
          break
        end
      end
    end
    return providers
  end

  def self.find_provider_by_name(provider_name)
    provider = @providers.select do |provider| 
      provider.name == provider_name
    end
    
    provider.first
  end

  def add_service(service)
    @services.push(service)
  end

  def remove_service(service_name)
    for service in @services do
      if service.name == service_name
        @services.delete(service)
      end
    end
  end

  def print_services
    puts "#{Magenta}#{@name}'s#{Reset} Services:"
    @services.each do |service|
      service.print_details
    end
  end

  def contains_service?(name)
    for service in @services do
      if service.name == name
        return service
      end
    end
    return false
  end
  
  def add_availability(start_timeblock, end_timeblock)
    #need to add a check here
    availability = Availability.new(start_timeblock, end_timeblock, self)
    @availabilities << availability
  end

  def add_appointment(service, timeblock, client)
    #add appointment to provider's schedule
    if is_available(service, timeblock, timeblock.is_weekly)
      puts("Success!")
      appointment = Appointment.new(timeblock, service, client, self)
      @appointments << appointment
    end
  end
  
  def is_available(service, timeblock, is_weekly)
    is_future_date = (timeblock.start_time >= DateTime.now)

    service_offered = contains_service?(service.name)

    provider_available = false
    puts @availabilities
    @availabilities.each do |availability|
      puts availability.timeblock
      if availability.timeblock.contains(timeblock)
        provider_available = true
      end
    end

    no_overlap_with_appointments = true
    @appointments.each do |appointment|
      if appointment.timeblock.is_weekly || is_weekly
        if appointment.timeblock.day_of_week == timeblock.day_of_week
          if appointment.timeblock.overlaps_time(timeblock)
            no_overlap_with_appointments = false
          end
        end
      end

      if appointment.timeblock.overlaps(timeblock)
        no_overlap_with_appointments = false
      end
    end

    return is_future_date && service_offered && 
      provider_available && no_overlap_with_appointments
  end

  def view_schedule
    puts "#{Magenta}#{@name}'s#{Reset} Appointments:"
    i = 1;
    @appointments.each do |a|
      puts "#{BgCyan}APPOINTMENT #{i}#{Reset}"
      a.print_details
      i += 1
    end
  end
end