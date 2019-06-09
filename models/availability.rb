require_relative '../models/timeblock'

class Availability
  attr_reader :start_time, :end_time, :service_provider
  
  def initialize(start_time, end_time, service_provider)
    @start_time = start_time
    @end_time = end_time
    @service_provider = service_provider
  end

  def timeblock
    TimeBlock.new(start_time, false, (@end_time - @start_time) * 60 * 24)
  end
end