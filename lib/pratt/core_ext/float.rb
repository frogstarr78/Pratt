class Float
  def pretty_print
    "%0.2f"% self
  end

  def percentage of_total = 1
    ( (self/of_total)*100.0 ).pretty_print << "%"
  end

  def to_money
    Money.new(self)
  end
end

class Money
  include Comparable
  
  def <=> other
    @f <=> other
  end

  def initialize f
    @f = Float(f)
  end

  def pretty_print
    "$#{@f.pretty_print}"
  end
end
