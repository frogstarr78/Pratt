class Whence < ActiveRecord::Base
  belongs_to :project

  def stop!
    self.end_at ||= DateTime.now #if end_at.nil?
    self.save
    self.reload
    self
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
