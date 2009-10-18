class Payment < ActiveRecord::Base
  belongs_to :billable, :polymorphic => true

  def pretty_print
    "$%0.2f"% (rate/100)
  end

  class << self
    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :payments do |t|
            t.references :billable, :polymorphic => true, :default => false
            t.integer :rate, :default => false
          end
        elsif which == :down
          drop_table :payments
        end
      end
    end
  end
end
