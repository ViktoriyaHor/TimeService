# frozen_string_literal: true

# adding the minutes to the time
module TimeService
  # initialize arguments
  class InitialTime
    attr_accessor :time, :mins

    def initialize
      @time = time
      @min = mins
    end
  end

  # subclass
  class TimeEdit < InitialTime

    def flux_capacitor(time, mins)
      #check if time in valid format
    time_match = time.strip.match /^(12|11|10|0?\d):([012345]\d)\s+(AM|PM)/

    #throw error on invalid time
    raise(ArgumentError, "Invalid time: #{time.strip}") if not time_match

    #calculate new time
    strhours, strminutes, meridian = time_match.captures
    hours = (meridian == "AM" ? strhours.to_i : strhours.to_i + 12)
    total_minutes = hours * 60 + strminutes.to_i + mins
    total_minutes = total_minutes % (24 * 60) # we only want the minutes that fit within a day
    adjusted_hours, adjusted_minutes = total_minutes.divmod(60)
    if adjusted_hours > 12
        adjusted_hours -= 12
        meridian = 'PM'
    else
        meridian = 'AM'
    end

    "%d:%02d %s" % [adjusted_hours, adjusted_minutes, meridian]
end

  end
end
test = TimeService::TimeEdit.new
p test.flux_capacitor("11:59 AM", 50)