class Date
  def beginning_of_week
    (self - wday_offset).beginning_of_day
  end

  def end_of_week
    (beginning_of_week+6).end_of_day
  end
end

class DateTime < Date
end
