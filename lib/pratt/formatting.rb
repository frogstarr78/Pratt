class Pratt

  @@color = true

  def padded_to_max string
    self.class.padded_to_max string
  end

  class << self

    def color
      @@color
    end

    def color= c
      @@color = c
    end

    def color?
      @@color == true
    end

    # Calculate totals. I think this should be an instance method on Projects/?/Whences
    def totals hr, fmt = false
      "#{fmt_i(hr / 24, 'day', :cyan)} #{fmt_i(hr % 24, 'hour', :yellow)} #{fmt_i((60*(hr -= hr.to_i)), 'min', :green)}"
    end

    def fmt_i int, label, color
      "%s #{label}"% [("%02i"% int).send(color), label]
    end

    def percent label, off, total, color
      percent = "%0.2f"% ((off/total)*100)
      padded_to_max(label) << " #{percent}%".send(color)
    end
    
    # Pad the output string to the maximum Project name
    def padded_to_max string
      project_padding = Project.longest_length_project
      "%#{project_padding}.#{project_padding}s"% string
    end
  end
end
