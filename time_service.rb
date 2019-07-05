# frozen_string_literal: true

# adding the minutes to the time
module TimeService
  # initialize arguments
  class InitialTime
    attr_accessor :time, :min

    def initialize(time, min)
      @time = time
      @min = min
    end

    # matching rule with string
    def rule
      @time_match = @time.strip.match(/^(12|11|10|0?\d):([012345]\d)\s+(AM|PM)/)
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

    # return meridian
    def meridian(adjusted_hours)
      if adjusted_hours > 12
        @adjusted_hours -= 12
        @meridian = 'PM'
      else
        @meridian = 'AM'
      end
    end

    def add_minutes
      transform
      hours = (@meridian == 'AM' ? @str_hours.to_i : @str_hours.to_i + 12)
      total_minutes = hours * 60 + @str_minutes.to_i + @min
      # we only want the minutes that fit within a day
      total_minutes = total_minutes % (24 * 60)
      @adjusted_hours, @adjusted_minutes = total_minutes.divmod(60)
      meridian(@adjusted_hours)
    end
  end

  # subclass
  class TimeEdit < InitialTime
    def output_result
      add_minutes
      printf('%d:%02d %s', @adjusted_hours, @adjusted_minutes, @meridian)
    end
  end
end

test = TimeService::TimeEdit.new('11:59 AM', 50)
test.output_result
