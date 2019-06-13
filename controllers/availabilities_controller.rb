require 'date'

class AvailabilitiesController

  def self.add
    provider_name = $input_strategy.ask('Provider Name:')
    add_to_provider(provider_name)
  end

  def self.add_to_provider(provider_name)
    date = add_date
    month = date.month
    day = date.day
    year = date.year
    start_and_end_times = add_start_and_end_times
    start_datetime = format_datetime(month, day, year, start_and_end_times[0])
    end_datetime = format_datetime(month, day, year, start_and_end_times[1])

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

  def self.add_date
    valid_date = false
    while !valid_date
      month = $input_strategy.ask('Date (MM):')
      day = $input_strategy.ask('Date (DD):')
      year = $input_strategy.ask('Date (YYYY):')
      if !valid_date?(month, day, year)
        puts("Please enter a valid future date.")
      else
        date = Date.parse("#{day}-#{month}-#{year}")
        valid_date = true
      end
    end
    date
  end

  def self.add_start_and_end_times
    loop do
      start_time = add_time("Start")
      end_time = add_time("End")
      if Time.parse(start_time) >= Time.parse(end_time)
        puts("End time must be after start time.")
      else
        return [start_time, end_time]
      end
    end
  end

  def self.add_time(start_or_end)
    valid_time = false
    while !valid_time
      time = $input_strategy.ask("#{start_or_end} Time (ex: 13:30):")
      if !valid_time?(time)
        puts("Please enter a valid time.")
      else
        valid_time = true
      end
    end
    time
  end

  def self.valid_date?(month, day, year)
    begin
      date = Date.parse("#{day}-#{month}-#{year}")
    rescue ArgumentError
      return false
    end
    date >= DateTime.now
  end

  def self.valid_time?(time_string)
    begin
      time = Time.parse(time_string)
    rescue ArgumentError
      return false
    end
    true
  end
end