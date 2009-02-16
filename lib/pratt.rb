require 'config'

module PrattM
  def self.ruby what
    system('ruby', what)
  end
  def ruby what
    self.class.ruby(what)
  end
end

class Pratt
  include Config
  include PrattM
  VERSION = '1.0.0'

  def self.run
    while(true)
      prefs = Pref.first
      ruby('lib/binary.rb')
      sleep prefs.interval
    end
  end

  change = Proc.new {
    last_log = Whence.last_started
    last_log.project = Project.find_or_create_by_name project_combo.get
    puts last_log.inspect
    last_log.save
    exit
  }
end
