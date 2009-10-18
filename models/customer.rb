class Customer < ActiveRecord::Base
  has_many :projects
  has_one :payment, :as => :billable

  def amount
    payment.rate / 100.0
  end
 
  class << self
    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :customers do |t|
            t.string :name, :null => false
            t.string :address
            t.string :zip, :limit => 5
          end
        elsif which == :down
          drop_table :customers
        end
      end
    end
  end
end
