add_column 'projects', :customer_id, :integer
Customer.migrate :up
qs = Customer.create :name => "QualitySmith LLC", :address => "106 N 2nd Street", :zip => "99362"
Project.update_all "customer_id = '#{qs.id}'"
Project.off.update_attribute :customer_id => 0
change_column_null 'projects', :customer_id, false
