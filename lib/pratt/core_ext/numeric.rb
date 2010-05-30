class Numeric
  def format_integer
    colored_integer = ("%02i"% self)
  end

  def with_label label
    self.to_s.with_label label
  end
end
