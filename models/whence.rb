class Whence < ActiveRecord::Base
  belongs_to :project

  class << self
    def migrate up = true 
      ActiveRecord::Schema.define do
        if up
          create_table :whences do |t|
            t.references :project
            t.datetime :start_at
            t.datetime :end_at
          end
        else
          drop_table :whences
        end
      end
    end
  end

  protected
    def validate
        errors.add "time", "end time must be greater than start time" unless end_at > start_at
    end
end
