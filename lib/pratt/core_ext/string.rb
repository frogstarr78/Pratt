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

class String
  def with_label label
    "#{padded_to_max(label)} #{self}"
  end

  private
    # Pad the output string to the maximum Project name
    def padded_to_max string
      project_padding = Project.longest_project_name
      "%#{project_padding}.#{project_padding}s"% string
    end
end
