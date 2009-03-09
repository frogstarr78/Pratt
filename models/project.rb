class Project < ActiveRecord::Base
  has_many :whences

  def start!
    whences.create :start_at => DateTime.now
  end
  def stop!
    # in case there isn't a previous log
    if wen = whences.last 
      # only set if not already set
      # aka don't reset existing entries
      wen.end_at ||= DateTime.now
      wen.save
    end
  end
  def restart!
    self.stop!
    self.start!
  end

  def time_spent fmt = false
    hr = (
      whences.all( :conditions => "end_at IS NOT NULL").inject(0.0) {|total, whence| 
        total += ( whence.end_at - whence.start_at )
      } / 3600
    )
    return "#{Project.fmt(hr / 24, 'days', :cyan, fmt)} #{Project.fmt(hr % 24, 'hours', :yellow, fmt)} #{Project.fmt((60*(hr -= hr.to_i)), 'minutes', :green, fmt)}"
  end

  class << self
    def fmt i, m, c, fmt = false
      "%s #{m}"% [("%02i"% i).send(fmt ? c : :to_s), m]
    end

    def named name
      find_cond name
    end
    def refactor
      find_cond 'Home Refactor'
    end
    def off
      find_cond 'Lunch/Break'
    end
    def rest
      all :conditions => ["name not in (?)", %w(Home\ Refactor Lunch/Break)]
    end

    def migrate up = true
      ActiveRecord::Schema.define do
        if up
          create_table :projects do |t|
            t.string  :name
            t.integer :weight, :default => -1
          end
        else
          drop_table :projects
        end
      end
      Project.create(
        [
          {
            :name => 'Home Refactor',
            :weight => 1
          },
          {
            :name => 'Lunch/Break',
            :weight => 0
          },
          {
            :name => 'Other',
            :weight => -1
          }
        ]
      ) if up
    end

    private
      def find_cond name
        first :conditions => ["name = ?", name]
      end
  end
end
