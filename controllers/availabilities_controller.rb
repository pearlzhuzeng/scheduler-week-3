require 'date'

class AvailabilitiesController
  def self.add
    provider_name = $input_strategy.ask('Provider Name:')
    add_to_provider(provider_name)
  end

  def self.add_to_provider(provider_name)
    month = $input_strategy.ask('Date (MM):')
    day = $input_strategy.ask('Date (DD):')
    year = $input_strategy.ask('Date (YYYY):')
    start_time = $input_strategy.ask('Start Time (ex: 13:30):')
    end_time = $input_strategy.ask('End Time (ex: 14:30):')
    start_datetime = format_datetime(month, day, year, start_time)
    end_datetime = format_datetime(month, day, year, end_time)

    provider = Provider.find_provider_by_name(provider_name)
    provider.add_availability(start_datetime, end_datetime)
  end

  private

  def self.format_datetime(month, day, year, time)
    hour_and_minute = time.split(':')
    hour = hour_and_minute[0]
    minute = hour_and_minute[1]
    DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i)
  end
end