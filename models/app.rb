class App < ActiveRecord::Base
  has_many :logs

  def log which, overwrite = false
    self.gui = which if (overwrite and gui?(which) ) || gui?('')
    save!
  end

  def gui? which = ''
    match = (self.gui == which)
    match
  end

  def unlock
    self.gui = ''
    self.save!
  end

  def interval= intvl
    write_attribute(:interval, intvl*60)
  end

  class << self
    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :apps do |t|
            t.integer :pid
            t.string  :gui,      :default => ''
            t.float   :interval, :default => 15.0*60
          end
          App.create!(:gui => '', :interval => 15.0)
        elsif which == :down
          drop_table :apps
        end
      end
    end
  end
end
