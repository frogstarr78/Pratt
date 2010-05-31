require 'models/pratt'

class Project < ActiveRecord::Base
  include Pratt::TimeSpent
  belongs_to :customer

  has_many :whences
  has_one :payment, :as => :billable
  
  validates_presence_of :name, :customer_id

  before_validation_on_create :set_to_customer_one

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

  def time_spent scale = nil, when_to = DateTime.now, &block
    whences_since = self.whences.find :all, :conditions => conditions_for_time_spent(scale, when_to)
    total_whences whences_since
  end

  def amount hour
    amount = hour * ( payment.rate / 100.0 )
    amount.to_money
  end

  def formatted_time_spent_totals hour
    "#{(hour / 24).format_integer.cyan} day #{(hour % 24).format_integer.yellow} hour #{(60*(hour -= hour.to_i)).format_integer.green} min"
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

    def longest_project_name
      project_names = all.collect(&:name)
      longest = project_names.inject(0) do |max, next_name|
        max = next_name.length if next_name.length > max
        max
      end
      longest
    end

    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :projects do |t|
            t.string  :name
            t.integer :weight, :default => -1
            t.references :customer, :null => false
          end
        elsif which == :down
          drop_table :projects
        end
      end
    end
  end

  private
    def set_to_customer_one
      self.customer = Customer.first
    end
end
