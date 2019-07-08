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
      @time.strip.match(/^(12|11|10|0?\d):([012345]\d)\s+(AM|PM)/)
    end

    # throw error on invalid time
    def error
      raise(ArgumentError, "Invalid time: #{@time.strip}") unless rule
    end

    # transform MatchData into array
    def transform
      error
      str_hours, str_minutes, meridian = rule.captures
      { hours: str_hours.to_i, minutes: str_minutes.to_i, meridian: meridian }
    end

    # return meridian
    def meridian_a(adjusted_hours)
      if adjusted_hours > 12
        @adjusted_hours -= 12
        'PM'
      else
        'AM'
      end
    end

    def add_minutes
      a = transform
      str_hours = a[:hours]
      str_minutes = a[:minutes]
      meridian = a[:meridian]
      hours = (meridian == 'AM' ? str_hours : str_hours + 12)
      total_minutes = hours * 60 + str_minutes + @min
      # we only want the minutes that fit within a day
      total_minutes % (24 * 60)
    end

    def split_minutes
      @adjusted_hours, adjusted_minutes = add_minutes.divmod(60)
      mer = meridian_a(@adjusted_hours)
      [@adjusted_hours, adjusted_minutes, mer]
    end
  end

  # subclass
  class TimeEdit < InitialTime
    def output_result
      a = split_minutes
      '%d:%02d %s' % [a[0], a[1], a[2]]
    end
  end
end

# test = TimeService::TimeEdit.new('10:00 AM', 600).add_minutes

p TimeService::TimeEdit.new('10:00 AM', 600).output_result
