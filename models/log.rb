require 'models/pratt'

class Log < ActiveRecord::Base
  belongs_to :app

  def before_save
    app = App.last
  end

  class << self
    def migrate up = :up
      ActiveRecord::Schema.define do
        create_table :logs do |t|
          t.references :app, :default => 1
          t.string     :message
          t.string     :level
        end if up == :up
        drop_table :logs if up == :down
      end
    end
  end
end
