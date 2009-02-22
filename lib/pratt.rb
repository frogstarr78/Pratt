require 'config'
require 'pratt_module'

class Pratt
  include Config
  include PrattM
  VERSION = '1.0.0'

  attr_reader :interval

  def initialize intvl = 15
    @interval = intvl.to_i*60
  end

  def main
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{Whence.last.project.name}'")
    sleep interval
  end

  def pop option
    system("ruby lib/pop.rb #{option}")
  end

  def do project, start_or_stop = :start
    Project.find_by_name(project).do(start_or_stop == :start)
  end

  class << self
    def run intvl = 15
      me = new intvl
      while(true)
        me.main
      end
    end

    def change project_name
      last_log = Whence.last_started
      last_log.project = Project.find_or_create_by_name project_name
      last_log.save
    end
  end
end
