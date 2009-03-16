require 'pathname'
require 'fileutils'
require 'rubygems'
require 'hoe'
require 'ruby-debug'
gem 'activerecord'
gem 'sqlite3-ruby'
require 'active_record'

include FileUtils

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
$LOAD_PATH << '.'
$LOAD_PATH << './lib'
$LOAD_PATH << './models'
$LOAD_PATH.uniq!

class Pratt
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
end

module Config

  class << self
    def models
      Pathname.glob File.join(Dir.pwd, 'models', '*.rb') do |path|
        require path
        name = path.basename('.rb').to_s.capitalize
        yield( Object.const_defined?(name) ? Object.const_get(name) : Object.const_missing(name) ) if block_given?
      end
    end
    def included base
      models
    end
  end
end

DBFILE = 'tracker.sqlite3' unless Object.const_defined?('DBFILE')

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :dbfile => DBFILE
)

unless File.exist?(DBFILE)
  include Config
  Project.migrate
  Whence.migrate
end
