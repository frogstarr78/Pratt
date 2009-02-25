require 'config'
require 'pratt_module'

class Pratt

  include Config
  include PrattM
  VERSION = '1.0.0'
  PID_FILE='pratt.pid'

  def initialize
  end

  def main
    projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
    system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{Whence.last.project.name}'")
  end

  def pop
    system("ruby lib/pop.rb '#{Whence.last.project.name}'")
  end

  def do action, project
    puts "action #{action}, project #{project}"
#    Project.find_by_name(project).do(start_or_stop == :start)
  end

  def change project_name
    last_log = Whence.last_started
    last_log.project = Project.find_or_create_by_name project_name
    last_log.save
  end

  def quit
    Process.kill("KILL", File.open(PID_FILE).readline.to_i) and self.class.xpid!
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
      (me = new).main
      pid!
      sleep(interval)
      while(true)
        me.pop
        sleep(interval)
      end
      xpid!
    end

    def pid?
      File.exists?(PID_FILE)
    end
    
    def xpid!
      rm PID_FILE
    end
    private
      def pid!
        File.open PID_FILE, 'w' do |f|
          f.write(Process.pid)
        end
      end
  end
end
