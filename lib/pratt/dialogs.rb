class Pratt
  def daemonized?
    !app.pid.blank? and ( cpid.to_i == app.pid )
  end

  def daemonize!
    defork { 
      puts "pratt (#{Process.pid.to_s.yellow})"
      app.pid = Process.pid
      app.save!

      gui
      while(daemonized?)
        sleep(app.interval)
        gui
      end
      quit
    }
  end

  def gui
    if Whence.last_unended
      pop
    else
      main
    end
  end

  def detect
    if self.daemonized?
      gui
    else
      daemonize!
    end
  end

  private
    def main
      reload_and_detect_lock 'main'
      projects = ([Project.primary, Project.off] | Project.rest).collect(&:name)
      if Whence.count == 0 
        # first run
        project = Whence.new(:project => Project.new)
        current_project_name = project.project.name
      else
        project = Whence.last_unended || Whence.last
        current_project_name = ''
      end

      if Project.count > 0
        projects = ([Project.primary, Project.off] | Project.rest).compact.collect(&:name)
      else
        projects = []
      end
      defork { 
        command = "ruby views/main.rb  --projects '#{projects*"','"}' --current '#{current_project_name}'"
        system command
      } 
    end

    def pop
      reload_and_detect_lock 'pop'
      self.project = Whence.last_unended.project
      defork do
        command = "ruby views/pop.rb  --project '#{project.name}' --start '#{project.whences.last_unended.start_at}' --project_time '#{Pratt.totals(project.time_spent)}'"
        system command
      end
    end

    def reload_and_detect_lock of
      self.app.reload
      return if self.app.gui? of
      self.app.log of
    end

    def defork &block
      Process.detach(
        fork &block 
      )
    end
end
