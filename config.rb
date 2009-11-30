require 'active_record'
PRATT_ENV = ENV["PRATT_ENV"] || 'development' unless Object.const_defined? :PRATT_ENV

class Pratt
  @@connected_to = nil
  module Test
  end

  include FileUtils

  class << self
    def connected_to?
      @@connected_to
    end

    def connect! to_env = :development
      puts "Connecting to: #{to_env}"
      @@connected_to = "db/#{to_env}.sqlite3"
      ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => connected_to? )
      unless File.exists? connected_to?
        Pratt.migrate
      end
    end

    def connected?
      ActiveRecord::Base.connected?
    end
    
    def config= env
      include Pratt::Test
    end
  end

end
