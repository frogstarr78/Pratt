class App < ActiveRecord::Base
 
  class << self
    def gui? which = '', log_err = false
      match = (self.last.gui == which)
      $stderr.write("#{which} already being displayed\n") if log_err
      match
    end

    def log which, overwrite = false
      me = last
      me.gui = which if (overwrite and gui?(which) ) || gui?('')
      me.save!
    end

    def gui which
      me = last
      me.gui = which
      me.save!
    end

    def rm which
      me = last
      me.gui = '' if gui?(which)
      me.save!
    end

    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table :apps do |t|
          t.string  :pid
          t.string  :gui
        end if up == :up
        drop_table :apps if up == :down
      end
      App.create! :gui => ''
    end
  end
end
