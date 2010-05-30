class Numeric
  def format_integer_with_label label, color
    colored_integer = ("%02i"% self).send(color) 
    colored_integer << " " << label
  end
end
