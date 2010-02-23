class Float
  def pretty_print
    "%0.2f"% self
  end

  def to_money
    Money.new(self)
  end
end

class Money
  def initialize f
    @f = Float(f)
  end
  def pretty_print
    "$#{@f.pretty_print}"
  end
end
