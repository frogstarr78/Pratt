class Customer < ActiveRecord::Base
  has_many :projects

  class << self
    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table :customers do |t|
          t.string :name, :null => false
          t.string :address
          t.string :zip, :limit => 5
        end if up == :up
        drop_table :customers if up == :down
      end
    end
  end
end
