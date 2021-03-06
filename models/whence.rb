require 'models/pratt'

class Whence < ActiveRecord::Base
  belongs_to :project
  has_many :invoice_whences
  has_many :invoices, :through => :invoice_whences
  validates_associated :project

  def stop! when_to
    if when_to.kind_of?(String)
      self.end_at = Chronic.parse(when_to)
    else
      self.end_at = when_to || DateTime.now
    end
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
    "#<Whence id: '#{id || ''}', project: '#{project ? project.name : ''}', start_at: '#{start_at? ? start_at.strftime(Pratt::FMT) : ''}', end_at: '#{end_at? ? end_at.strftime(Pratt::FMT) : ''}', invoiced: #{invoiced ? 'true' : 'false'}>"
  end

  def invoiced?
	read_attribute(:invoiced) == true
  end
  
  class << self
    include Pratt::TimeSpent

    def time_spent scale = nil, when_to = Time.now
      whences_since = Whence.find :all, :conditions => conditions_for_time_spent(scale, when_to)
      total_whences whences_since
    end

    def last_unended
      first :conditions => "end_at IS NULL", :order => "start_at DESC"
    end

    def migrate which = :up 
      ActiveRecord::Schema.define do
        if which == :up
          create_table :whences do |t|
            t.references :project
            t.datetime :start_at
            t.datetime :end_at
            t.boolean :invoiced, :default => false
          end
        elsif which == :down
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
