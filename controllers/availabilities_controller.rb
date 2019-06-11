require_relative '../lib/prompt_input_strategy'

class AvailabilitiesController
  def self.add(*args)
    provider_name = PromptInputStrategy.new.ask('Provider Name:')
    month = PromptInputStrategy.new.ask('Date (MM):')
    day = PromptInputStrategy.new.ask('Date (DD):')
    year = PromptInputStrategy.new.ask('Date (YYYY):')
    start_time = PromptInputStrategy.new.ask('Start Time (ex: 13:30):')
    end_time = PromptInputStrategy.new.ask('End Time (ex: 14:30):')
    start_temp = start_time.split(':')
    start_hour = start_temp[0].to_i
    start_minute = start_temp[1].to_i

    end_temp = end_time.split(':')
    end_hour = end_temp[0].to_i
    end_minute = end_temp[1].to_i

    provider = Provider.find_provider_by_name(provider_name)

    start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, start_hour, start_minute)
    end_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, end_hour, end_minute)

    provider.add_availability(start_datetime, end_datetime)
  end
end