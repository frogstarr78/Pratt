class Pratt
  module ColorString

    COLORS = { 
      'black'   => 30,
      'red'     => 31, 
      'green'   => 32, 
      'yellow'  => 33,
      'blue'    => 34,
      'magenta' => 35,
      'cyan'    => 36,
      'white'   => 37
    }.each do |color, key|
      define_method color do
        return self unless Pratt.color?
        "\e[#{key}m#{self}#{clear}"
      end
    end

    def clear
      "\e[0m"
    end
  end
end

String.send :include, Pratt::ColorString
