class Pratt
  module TimeSpent
    def conditions_for_time_spent scale = nil, when_to = DateTime.now
      when_to = Chronic.parse(when_to) if when_to.is_a?(String)
      cond = ["end_at IS NOT NULL"]
      cond = [(cond << "start_at BETWEEN ? AND ?").join(' AND ')] | [when_to.send("beginning_of_#{scale}"), when_to.send("end_of_#{scale}")] unless scale.nil?
      cond
    end

    def spent what
      Proc.new {|*scale_when|
        scale, when_to = scale_when
        what.send(:all, :conditions => conditions_for_time_spent(scale, when_to) ).inject(0.0) {|total, whence| 
          total += ( whence.end_at - whence.start_at )
        } / 3600
      }
    end
  end
end
