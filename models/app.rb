class App < ActiveRecord::Base
  has_many :logs

  def log which, overwrite = false
    self.gui = which if (overwrite and gui?(which) ) || gui?('')
    save!
  end

  def gui? which = '', log_err = false
    match = (self.gui == which)
#    $stderr.write("#{which} already being displayed\n") if log_err
    match
  end

  def rm which
    self.gui = '' if gui?(which)
    save!
  end

  class << self
    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table :apps do |t|
          t.integer :pid
          t.string  :gui
        end if up == :up
        drop_table :apps if up == :down
      end
      App.create!(:gui => '') if up == :up
    end
  end
end
