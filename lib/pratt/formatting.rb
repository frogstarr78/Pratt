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
      "#{(hr / 24).format_integer.cyan} day #{(hr % 24).format_integer.yellow} hour #{(60*(hr -= hr.to_i)).format_integer.green} min"
    end
  end
end
