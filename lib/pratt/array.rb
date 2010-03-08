class Pratt
  class Formats
    module Array
      ##
      # Turns an array into a sentence
      #
      # @param [String] conjunction
      # @return [String] 
      def to_sentence conjunction = 'and'
        self[0..-2].join(", ") << (self.size > 2 ? ',' : '') << " #{conjunction} #{self.last}"
      end
    end
  end
end

Array.send :include, Pratt::Formats::Array
