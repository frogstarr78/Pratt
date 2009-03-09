require 'config'
require 'colored'

class Pratt

  include Config
  VERSION = '1.0.0'
  PID_FILE='pratt.pid'

  class << self
    def quit
      Process.kill("KILL", File.open(PID_FILE).readline.to_i) && rm(PID_FILE)
    end

    def main
      projects = ([Project.refactor, Project.off] | Project.rest).collect(&:name)
      Process.detach(
        fork { system("ruby lib/main.rb --projects '#{projects*"','"}' --current '#{Whence.last.project.name}'") } 
      )
    end

    def pop
      project = Whence.last.project
      Process.detach(
        fork { system("ruby lib/pop.rb '#{project.name}' '#{project.time_spent}'") } 
      )
    end

    def run interval = 15.0
      Process.detach(
        fork {
          daemonize!
          (me = new).main
          while(daemonized?)
            sleep(interval*60)
            me.pop
          end
        }
      )
    end

    def daemonized?
      File.exists?(PID_FILE) and File.open(PID_FILE).readline.to_i != 0
    end

    private
      def pid
        File.open(PID_FILE).readline.to_i
      end

      def daemonize!
#        return if daemonized?
        puts "pratt (#{Process.pid.to_s.yellow})"
        File.open(PID_FILE, 'w') {|f| f.write(Process.pid) }
      end
  end
end
