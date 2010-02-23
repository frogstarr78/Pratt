class Invoice < ActiveRecord::Base
	belongs_to :customer
	has_many :invoice_whences
	has_many :whences, :through => :invoice_whences

	validates_presence_of :customer_id, :weekday_start
	validates_format_of :invoice_number, :with => /(0?[1-9]+[0-9]*)-([0-4][0-9]|5[0-4])-(0?[1-9]+[0-9]*)/, :on => :create

	def before_validation_on_create
	  self.invoice_number = "%s-%s-%s"% [customer.id, weekday_start.week, customer.invoices.count+1 ]
	end

    def self.migrate which = :up 
      ActiveRecord::Schema.define do
        if which == :up
          create_table :invoices do |t|
            t.references :customer
			t.datetime :weekday_start
			t.datetime :weekday_end
            t.string 'invoice_number'
			t.integer :total
          end
        elsif which == :down
          drop_table :invoices
        end
      end
    end
end
