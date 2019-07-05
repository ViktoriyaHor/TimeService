# frozen_string_literal: true

# adding the minutes to the time
module TimeService
  # initialize arguments
  class InitialTime
    attr_accessor :time, :min, :time_match

    def initialize
      @time = time
      @min = min
      @time_match = time_match
    end

    # matching rule with string
    def rule
      @time_match = @time.strip.match /^(12|11|10|0?\d):([012345]\d)\s+(AM|PM)/
    end

    # throw error on invalid time
    def error
      rule
      raise(ArgumentError, "Invalid time: #{@time.strip}") unless @time_match
    end

    # transform MatchData into array
    def transform
      error
      @str_hours, @str_minutes, @meridian = @time_match.captures
    end

    def add_minutes
      transform
      hours = (@meridian == 'AM' ? @str_hours.to_i : @str_hours.to_i + 12)
      total_minutes = hours * 60 + @str_minutes.to_i + @min
      total_minutes = total_minutes % (24 * 60) # we only want the minutes that fit within a day
      @adjusted_hours, @adjusted_minutes = total_minutes.divmod(60)
      if @adjusted_hours > 12
        @adjusted_hours -= 12
        @meridian = 'PM'
      else
        @meridian = 'AM'
      end
    end
  end

  # subclass
  class TimeEdit < InitialTime
    def output_result(time_add, min_add)
      @time = time_add
      @min = min_add
      add_minutes
      '%d:%02d %s' % [@adjusted_hours, @adjusted_minutes, @meridian]
    end
  end
end

test = TimeService::TimeEdit.new
p test.output_result('10:59 AM', 50)