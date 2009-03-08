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

  def time_spent
    min = whences.all( :conditions => "end_at IS NOT NULL").inject(0.0) {|total, whence| 
      total += ( whence.end_at - whence.start_at )
    }
    min /= 60
    if min > 60
      hr = (min / 60)
      if hr > 24
        return "#{(hr / 24).to_i.to_s.magenta} days #{(hr%24).to_i.to_s.green} hours #{(60*(hr -= hr.to_i)).to_i.to_s.cyan} minutes"
      else
        return "#{hr.to_i.to_s.green} hours #{(60*(hr -= hr.to_i)).to_i.to_s.cyan} minutes"
      end
    else
      return "#{min.to_i.to_s.cyan} minutes"
    end
  end

  class << self
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
            t.column :name, :string
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
