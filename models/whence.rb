class Whence < ActiveRecord::Base
  belongs_to :project

  class << self
    def last_started
      find :last, :order => "start_at ASC"
    end

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
end
