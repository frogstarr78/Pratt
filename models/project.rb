require 'models/pratt'

class Project < ActiveRecord::Base
  include Pratt::Models
  belongs_to :customer

  has_many :whences
  has_one :payment, :as => :billable
  
  validates_presence_of :name

  def start! at = DateTime.now
    at = Chronic.parse(at) if at.is_a?(String)
    whences.create :start_at => at
  end
  def stop! at = DateTime.now
    if whence = whences.last_unended
      whences.last_unended.stop!(at)
    end
  end
  def restart! at = DateTime.now
    self.stop! at
    self.start! at
  end

  def time_spent scale = nil, when_to = Time.now
    spent(self.whences).call(scale, when_to)
  end

  def amount scale = nil, when_to = Time.now
    spent(self.whences).call(scale, when_to) * (payment.rate / 100.0)
  end

  class << self
    def named name
      first :conditions => { :name => name }
    end
    def primary
      first :conditions => { :weight => 1 }
    end
    def off
      named 'Lunch/Break'
    end
    def rest
      all - [primary, off]
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
  end
end
