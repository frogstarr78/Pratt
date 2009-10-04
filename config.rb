require 'active_record'

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
Pratt.connect :development
#migrate
