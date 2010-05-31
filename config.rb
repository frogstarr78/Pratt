PRATT_ENV = ENV["PRATT_ENV"] || 'development' unless Object.const_defined? :PRATT_ENV

class Pratt
  include FileUtils

  class << self
    def connect! to_env = :development
      connect_to = "db/#{to_env}.sqlite3"
      ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => connect_to  )
      unless File.exists? connect_to
        Pratt.migrate
      end
    end

    def connected?
      ActiveRecord::Base.connected?
    end
  end
end
