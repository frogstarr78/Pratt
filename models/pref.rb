class Pref < ActiveRecord::Base
  class << self
    def migrate up = true
      ActiveRecord::Schema.define do
        if up
          create_table :prefs do |t|
            t.string :log_level
            t.integer :interval, :default => 900, :nil => false
          end
          Pref.create( :log_level => 'binary' ) if up
        else
          drop_table :prefs
        end
      end

    end
  end
end
