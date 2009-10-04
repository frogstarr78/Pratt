require 'active_record'
PRATT_ENV = ENV["PRATT_ENV"] || 'development' unless Object.const_defined? :PRATT_ENV

class Pratt
  include FileUtils

  class << self
    def connect to_env = :development
      puts "Connecting to: #{to_env}"
      ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database  => "#{to_env}.sqlite3" )
    end

    def connected?
      ActiveRecord::Base.connected?
    end
  end

end

#include Pratt::Config
#Pratt.connect :production
Pratt.connect PRATT_ENV
#migrate
