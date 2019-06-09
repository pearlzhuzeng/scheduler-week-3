class TimeBlock
  attr_reader :month, :day, :year, :start_time, :end_time, :day_of_week, :is_weekly

  def initialize(start_time, is_weekly, length)
    @month = start_time.strftime("%m")
    @day = start_time.strftime("%d")
    @year = start_time.strftime("%Y")
    @start_time = start_time
    @is_weekly = is_weekly
    @end_time = start_time + ((length.to_f)/24)/60
    @day_of_week = start_time.strftime("%A")
  end

  def contains(other_timeblock)
    #return true if the timeblock contains other_timeblock
    starts_after = (other_timeblock.start_time >= @start_time)
    ends_before = (other_timeblock.end_time <= @end_time)
    return starts_after && ends_before
  end

  def overlaps(other_timeblock)
  	#returns true if timeblocks overlap
    check1 = (other_timeblock.start_time < @end_time &&
        other_timeblock.end_time > @start_time)
    check2 = (@start_time < other_timeblock.end_time &&
        @end_time > other_timeblock.start_time)
    return check1 || check2
  end

  def overlaps_time(other_timeblock)
  	#returns true if timeblocks overlap (regardless of date)
  	startTime1 = Time.parse(@start_time.strftime("%I:%M:%S %z"))
  	startTime2 = Time.parse(other_timeblock.start_time.strftime("%I:%M:%S %z"))
  	endTime1 = Time.parse(@end_time.strftime("%I:%M:%S %z"))
  	endTime2 = Time.parse(other_timeblock.end_time.strftime("%I:%M:%S %z"))

  	check1 = (startTime2 < endTime1 &&
        endTime2 > startTime1)

    check2 = (startTime1 < endTime2 &&
        endTime1 > startTime2)
    return check1 || check2
  end

  def calculate_endtime(start_time, length)
    return start_time + ((length.to_f)/24)/60
  end
end