require 'config'
require 'pratt_module'

class Pratt
  include Config
  include PrattM
  VERSION = '1.0.0'


  def initialize
  end

  def main
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{Whence.last.project.name}'")
  end

  def pop
    system("ruby lib/pop.rb '#{Whence.last.project.name}'")
  end

  def do project, start_or_stop = :start
    Project.find_by_name(project).do(start_or_stop == :start)
  end

  class << self
    def interval
      @@interval || 15*60
    end

    def interval= i
      @@interval = i*60
    end

    def run intvl = 15
      self.interval = intvl
      puts interval
      exit
      me = new
      me.main && sleep(interval)
      while(true)
        me.pop && sleep(interval)
      end
    end

    def change project_name
      last_log = Whence.last_started
      last_log.project = Project.find_or_create_by_name project_name
      last_log.save
    end
  end
end
