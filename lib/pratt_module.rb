module PrattM
  public 
    def self.ruby what
      system('ruby', what)
    end
    def ruby what
      self.class.ruby(what)
    end
end
