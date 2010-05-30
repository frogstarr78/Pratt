class Pratt

  @@color = true

  class << self

    def color
      @@color
    end

    def color= color_bool
      @@color = color_bool
    end

    def color?
      @@color == true
    end

    # Calculate totals. I think this should be an instance method on Projects/?/Whences
    def totals hr, fmt = false
      "#{(hr / 24).format_integer_with_label( 'day', :cyan )} #{(hr % 24).format_integer_with_label( 'hour', :yellow )} #{(60*(hr -= hr.to_i)).format_integer_with_label( 'min', :green )}"
    end

    def percent label, off, total, color
      percent = "%0.2f"% ((off/total)*100)
      padded_to_max(label) << " #{percent}%".send(color)
    end
    
    # Pad the output string to the maximum Project name
    def padded_to_max string
      project_padding = Project.longest_project_name
      "%#{project_padding}.#{project_padding}s"% string
    end
  end
end
