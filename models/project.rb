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
