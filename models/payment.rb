class Payment < ActiveRecord::Base
  belongs_to :billable, :polymorphic => true

  class << self
    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table :payments do |t|
          t.references :billable, :polymorphic => true, :default => false
          t.integer :rate, :default => false
        end if up == :up
        drop_table :payments if up == :down
      end
    end
  end
end
