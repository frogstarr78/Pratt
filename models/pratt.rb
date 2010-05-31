class Pratt
  module TimeSpent
    def conditions_for_time_spent scale = nil, when_to = DateTime.now
      when_to = Chronic.parse(when_to) if when_to.is_a?(String)
      cond = ["end_at IS NOT NULL"]
      cond = [(cond << "start_at BETWEEN ? AND ?").join(' AND ')] | [when_to.send("beginning_of_#{scale}"), when_to.send("end_of_#{scale}")] unless scale.nil?
      cond
    end

    def total_whences whences_since
      seconds = whences_since.inject(0.0) {|total, whence| total += ( whence.end_at - whence.start_at ) }
      hour = seconds / 3600
    end
  end
end
