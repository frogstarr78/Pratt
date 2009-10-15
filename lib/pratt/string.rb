class Pratt
  module ColorString
    def or format_alternative
      return self unless Pratt.color?
      format_alternative
    end
  end

  module Colored
    def colorize(string, options = {})
      return self unless Pratt.color?
      super 
    end
  end
end

String.send :include, Pratt::ColorString
String.send :include, Pratt::Colored
