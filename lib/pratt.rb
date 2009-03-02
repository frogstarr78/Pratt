require 'config'

class Pratt

  include Config
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
    Project.find_by_name(project).send action
  end
  def change project_name
    last_log = Whence.last
    last_log.project = Project.find_or_create_by_name project_name
    last_log.save
  end

  def quit
    Process.kill("KILL", File.open(PID_FILE).readline.to_i) and self.class.rm_pid!
  end

  class << self
    def interval
      @@interval || 15*60
    end
    def interval= i
      @@interval = i*60
    end

    def run intvl = 15, daemonize = false
      self.interval = intvl
      (me = new).main
      daemonize!
      sleep(interval)
      while(daemonized?)
        me.pop
        sleep(interval)
      end
      rm_pid!
    end

    def daemonized?
      File.exists?(PID_FILE)
    end
    
    def rm_pid!
      rm PID_FILE
    end
    private
      def daemonize!
        puts "pratt (#{Process.pid})"
        File.open PID_FILE, 'w' do |f|
          f.write(Process.pid)
        end
      end
  end
end
