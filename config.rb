require 'pathname'
require 'fileutils'
require 'rubygems'
require 'hoe'
require 'ruby-debug'
gem 'activerecord'
gem 'sqlite3-ruby'
require 'active_record'
require 'chronic'

include FileUtils

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
$LOAD_PATH << '.'
$LOAD_PATH << './lib'
$LOAD_PATH << './models'
$LOAD_PATH.uniq!

class Pratt
  DBFILES = (
    Dir.glob("*.sqlite3").collect {|file| file.split('.').first }
  )

  class << self
    def connect to_env = :development
      ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :dbfile  => case to_env
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

  module Models
    def conditions_for_time_spent scale = nil, when_to = Time.now
      when_to = Chronic.parse(when_to) if when_to.is_a?(String)
      cond = ["end_at IS NOT NULL"]
      cond = [(cond << "start_at BETWEEN ? AND ?").join(' AND ')] | [when_to.send("beginning_of_#{scale}"), when_to.send("end_of_#{scale}")] unless scale.nil?
      cond
    end

    def spent what
      Proc.new {|*scale_when|
        scale, when_to = scale_when
        what.send(:all, :conditions => conditions_for_time_spent(scale, when_to) ).inject(0.0) {|total, whence| 
          total += ( whence.end_at - whence.start_at )
        } / 3600
      }
    end
  end

  module Config

    def self.included base
      model_files {|path| require path }
    end

    def model_files &block
      Pathname.glob( File.join(Dir.pwd, 'models', '*.rb') ).each {|f| 
        yield f
      }
    end

    def migrate
      DBFILES.each do |db|
        Pratt.connect db
        model_files do |path|
          klass = File.basename( path, '.rb' ).capitalize.constantize
          begin
            ActiveRecord::Base.connection.execute("
              CREATE VIEW INFORMATION_SCHEMA_TABLES AS 
                SELECT 'main' AS TABLE_CATALOG,
                       'sqlite' AS TABLE_SCHEMA,
                       tbl_name AS TABLE_NAME,
                       CASE WHEN type = 'table' THEN 'BASE TABLE' WHEN type = 'view' THEN 'VIEW' END AS TABLE_TYPE,
                       sql AS TABLE_SOURCE
                  FROM sqlite_master
                 WHERE type IN ('table', 'view')
                   AND tbl_name NOT LIKE 'INFORMATION_SCHEMA_%'
              ORDER BY TABLE_TYPE, TABLE_NAME;
            ")
          rescue ActiveRecord::StatementInvalid
          end
          unless ActiveRecord::Base.connection.select_value("SELECT * FROM INFORMATION_SCHEMA_TABLES WHERE TABLE_NAME = '#{klass.table_name}'")
            klass.migrate :up
          end
        end
      end
    end
  end
end

Pratt.connect :production
include Pratt::Config
migrate
