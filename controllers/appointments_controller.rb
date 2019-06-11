require 'date'
require_relative '../lib/prompt_input_strategy'
require_relative '../helpers/utility_helper'
require_relative '../models/appointment'
require_relative '../models/timeblock'

class AppointmentsController
  def self.add(*args)
    client_name = PromptInputStrategy.new.ask('Your Name:')
    puts "Hello #{client_name}! Please choose provider & service to schedule."
    UtilityHelper.new.print_provider_services(Provider.all)

    provider_name = PromptInputStrategy.new.ask('Provider Name:')
    service_name = PromptInputStrategy.new.ask('Service Name:')
    month = PromptInputStrategy.new.ask('Date (MM):')
    day = PromptInputStrategy.new.ask('Date (DD):')
    year = PromptInputStrategy.new.ask('Date (YYYY):')
    start_time = PromptInputStrategy.new.ask('Start Time (ex: 13:30):')

    temp = start_time.split(':')
    hour = temp[0].to_i
    minute = temp[1].to_i

    puts 'Will This Appointment Reoccur Weekly?'
    is_weekly = UtilityHelper.new.yes_or_no
    puts(is_weekly)
    provider = Provider.find_provider_by_name(provider_name)
    service = provider.contains_service?(service_name)

    start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, hour, minute)

    timeblock = TimeBlock.new(start_datetime, is_weekly, service.length)

    provider.add_appointment(service, timeblock, client_name)
  end
end