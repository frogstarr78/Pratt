class Customer < ActiveRecord::Base

  class << self
    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table customers do |t|
        end if up == :up
        drop_table customers if up == :down
      end
    end
  end
end
