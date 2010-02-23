class InvoiceWhence < ActiveRecord::Base
	belongs_to :invoice
	belongs_to :whence

    def self.migrate which = :up 
      ActiveRecord::Schema.define do
        if which == :up
          create_table :invoice_whences do |t|
            t.references :invoice
			t.references :whence
			t.datetime :created_at
          end
        elsif which == :down
          drop_table :invoice_whences
        end
      end
    end
end
