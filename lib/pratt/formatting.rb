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
  end
end
