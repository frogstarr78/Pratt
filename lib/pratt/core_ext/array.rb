class Pratt
  class Formats
    module Array
      ##
      # Turns an array into a sentence
      #
      # @param [String] conjunction
      # @return [String] 
      def to_sentence conjunction = 'and'
        if self.size >= 2
          self[0..-2].join(", ") << (self.size > 2 ? ',' : '') << " #{conjunction} #{self.last}"
        elsif self.size <= 1
          self.first.to_s
        end
      end
    end
  end
end

Array.send :include, Pratt::Formats::Array
