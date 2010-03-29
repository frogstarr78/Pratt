class Zip < ActiveRecord::Base

  validates_presence_of :zip, :city, :ST, :state, :longitude, :latitude

  def before_validation_on_create
    self.ST = self.state[0,2].upcase
  end

  class << self
    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :zips do |t|
            t.string :zip,      :null => false
			t.string :city,     :null => false
			t.string :ST,       :null => false, :limit => 2
			t.string :state,    :null => false
            t.float :longitude, :null => false
            t.float :latitude,  :null => false
          end
        elsif which == :down
          drop_table :zips
        end
      end
    end
  end
end
