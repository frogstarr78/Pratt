require 'active_record'

class Pratt
  include FileUtils
  DBFILES = (
    Dir.glob("*.sqlite3").collect {|file| file.split('.').first }
  )

  class << self
    def connect to_env = :development
      ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :database  => case to_env
        when :production, 'production'
          'production.sqlite3'
        when :test, 'test'
          'test.sqlite3'
        else
          "#{to_env}.sqlite3"
        end
      )
    end

    def connected?
      ActiveRecord::Base.connected?
    end
  end

end

#include Pratt::Config
Pratt.connect :production
#migrate
