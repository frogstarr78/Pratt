require 'models/pratt'

class Project < ActiveRecord::Base
  include Pratt::Models
  belongs_to :customer

  has_many :whences
  has_one :payment, :as => :billable
  
  validates_presence_of :name, :customer_id

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

  def time_spent scale = nil, when_to = DateTime.now
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

    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :projects do |t|
            t.string  :name
            t.integer :weight, :default => -1
            t.references :customer, :null => false
          end

          Project.create(
            [
              {
                :name => 'Refactor',
                :weight => 1,
                :customer_id => 0
              },
              {
                :name => 'Lunch/Break',
                :weight => 0,
                :customer_id => 0
              },
              {
                :name => 'Other',
                :weight => -1,
                :customer_id => 0
              }
            ]
          )
        elsif which == :down
          drop_table :projects
        end
      end
    end
  end
end
