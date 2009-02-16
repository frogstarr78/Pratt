require 'pathname'
require 'rubygems'
require 'hoe'
require 'ruby-debug'
gem 'activerecord'
gem 'sqlite3-ruby'

require 'tk'
require 'tkextlib/tile'
require 'active_record'

$LOAD_PATH << '.'
$LOAD_PATH << './lib'
$LOAD_PATH << './models'
$LOAD_PATH.uniq!


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
