class Pratt

  # TODO Rename
  def graph
    self.template = 'graph'

    if project?
      @projects = [project]
    else
      @projects = Project.all
    end

    process_template!
  end

  def proportions
    @primary = @off_total = @rest_total = 0.0
    self.template = 'proportions'

    if project?
      @projects = [project]

      @primary = project.time_spent(scale, when_to)
      @scaled_total = project.time_spent(scale, when_to)
    else
      @projects = Project.all

      @projects.each do |proj| 
        @primary     = proj.time_spent(scale, when_to) if proj.name == Project.primary.name
        @off_total   = proj.time_spent(scale, when_to) if proj.name == Project.off.name
        @rest_total += proj.time_spent(scale, when_to) if Project.rest.collect(&:name).include?(proj.name)
      end
      @scaled_total = Whence.time_spent(scale, when_to) - @off_total
    end

    if @primary + @off_total + @rest_total > 0.0
      process_template!
    else
      "No data to report"
    end
  end

  # Generate an invoice for a given time period
  def invoice
    self.template ||= 'invoice'

    if project?
      @projects = [project]

      @total = project.amount( project.time_spent(scale, when_to) )
    else
      @projects = (Project.all - [Project.primary, Project.off])
      @projects = @projects.select {|proj| show_all or ( !show_all and proj.time_spent(scale, when_to) != 0.0 ) }

      @total = @projects.inject 0.0 do |total, proj| 
        total += proj.amount( proj.time_spent(scale, when_to) )
        total
      end
    end

    @projects.each do |project| 
      puts "<!-- #{project.name} #{project.payment.inspect} -->"
    end
    if @total > 0.0
      process_template!
    else
      puts "No data to report"
    end
  end

  def current
    self.template = 'current'
    @last_whence = Whence.last_unended || Whence.last || Whence.new( :end_at => nil, :project => Project.new )

    projects = ([Project.primary, Project.off] | Project.rest).compact
    @project_names = projects.collect do |proj| 

      if @last_whence.end_at.nil? && @last_whence.project.name == proj.name
        colored_name = proj.name.green
      else
        colored_name = proj.name.magenta
      end
      "'" << colored_name << "'"
    end
    @time_til = ( app.interval - ( Time.now - @last_whence.start_at ) ) if @last_whence.end_at.nil?

    process_template!
  end

  def raw
    self.template = 'raw'

    if project?
      @whences = project.whences.all
    else
      case raw_conditions
        when 'all'
          @whences = Whence.find raw_conditions.to_sym
        when /^last$/, 'first'
          @whences = [Whence.find raw_conditions.to_sym]
        when /last[\(\s]?(\d+)[\)\s]?/
          @whences = Whence.all.last($1.to_i)
        else
          @whences = Whence.all :conditions => ["start_at > ?", Chronic.parse("today 00:00")]
      end
    end
    @whences.sort_by(&:id)
    process_template!
  end

  def cpid
    `pgrep -fl 'bin/pratt'`.chomp.split(' ').first
  end

  def pid
    self.template = 'pid'
    process_template!
  end

  private
    def process_template!
      input = File.open(Pratt.root("views", "#{template}.eruby").first).read
      erubis = Erubis::Eruby.new(input)
      puts erubis.evaluate(self)
    end

end
