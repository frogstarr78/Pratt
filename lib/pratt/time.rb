class Date
  ##
  # Return "zero hour" of the first day of the, possibly shifted, week.
  #
  # @return [Date]
  def beginning_of_week
    (self - wday_offset).beginning_of_day
  end

  ##
  # Return "last second" of the last day of the, possibly shifted, week.
  #
  # @return [Date]
  def end_of_week
    (beginning_of_week+6).end_of_day
  end
end

class DateTime < Date
end
