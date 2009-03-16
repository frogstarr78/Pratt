class Whence < ActiveRecord::Base
  belongs_to :project
  validates_associated :project

  def stop! at = DateTime.now
    self.end_at ||= at
    self.save!
    self.reload
    self
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
  
  class << self
    include Pratt::Models
    def time_spent scale = nil, when_to = Time.now
      spent(self).call(scale, when_to)
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
