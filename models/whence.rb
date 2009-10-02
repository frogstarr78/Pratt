class Whence < ActiveRecord::Base
  belongs_to :project
  validates_associated :project

  def stop! when_to = DateTime.now
    when_to = Chronic.parse(when_to) if when_to.is_a?(String)
    self.end_at ||= when_to
    self.save!
    self.reload
  end
  def change! to_project
    self.project = Project.find_or_create_by_name(to_project)
    self.save!
    self.reload
  end

  def start_at
    sa = read_attribute(:start_at)
    class << sa
      def to_s
        self.strftime("%a %d %b %Y %X")
      end
    end
    sa
  end

  def inspect
    format = ""
    "#<Whence id: '#{id}', project: '#{project.name}', start_at: '#{start_at.strftime(Pratt::FMT)}', end_at: '#{end_at.strftime(Pratt::FMT)}'>"
  end
  
  class << self
    include Pratt::Models
#    def conditions_for_time_spent scale = nil, when_to = Time.now, *rest
#      when_to = Chronic.parse(when_to) if when_to.is_a?(String)
#      cond = ["end_at IS NOT NULL"]
#      cond = [(cond << "start_at BETWEEN ? AND ?").join(' AND ')] | [when_to.send("beginning_of_#{scale}"), when_to.send("end_of_#{scale}")] unless scale.nil?
#      cond << rest
#    end
    def time_spent scale = nil, when_to = Time.now
      spent(self).call(scale, when_to)
#      Proc.new {|*scale_when|
#        scale, when_to, rest = scale_when
#        what.send(:all, :conditions => conditions_for_time_spent(scale, when_to, rest), :include => :project ).inject(0.0) {|total, whence| 
#          total += ( whence.end_at - whence.start_at )
#        } / 3600
#      }
    end

    def last_unended
      first :conditions => "end_at IS NULL", :order => "start_at DESC"
    end

    def migrate up = true 
      ActiveRecord::Schema.define do
        if up
          create_table :whences do |t|
            t.references :project
            t.datetime :start_at
            t.datetime :end_at
          end
        else
          drop_table :whences
        end
      end
    end
  end

  protected
    def validate
      if end_at
        errors.add "time", "end time must be greater than start time" unless end_at > start_at
      end
    end
end
