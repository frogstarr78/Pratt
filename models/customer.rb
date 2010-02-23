class Customer < ActiveRecord::Base
  has_many :projects
  has_many :invoices
  has_one :payment, :as => :billable

  validates_presence_of :name

  def amount
    payment.rate / 100.0
  end

  def phone
    phone = read_attribute(:phone)
    class << phone
      def pretty_print sep = '.'
        self.split(/(\d{3})(\d{3})(\d{4})/)[1,3] * sep
      end
    end
    phone
  end

  def city_state_zip
    a_zip = Zip.find_by_zip(self.zip)
    return "#{a_zip.city}, #{a_zip.ST} #{a_zip.zip}" if a_zip
    return self.zip
  end
 
  class << self
    def migrate which = :up
      ActiveRecord::Schema.define do
        if which == :up
          create_table :customers do |t|
            t.string :name, :null => false
            t.string :company_name
            t.string :address
            t.string :phone
            t.string :zip, :limit => 5
          end
        elsif which == :down
          drop_table :customers
        end
      end
    end
  end
end
