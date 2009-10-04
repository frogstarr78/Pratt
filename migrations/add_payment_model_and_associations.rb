#zach = Customer.find_or_create_by_name :name => 'Pointmedi@ Firm', :zip => '99362'
#tb = Project.find_or_create_by_name :name => 'TwitterBug', :customer => zach
#Payment.migrate :up
#Payment.create :rate => 3000*100, :billable => tb

qs = Customer.find_by_name 'QualitySmith LLC'
qs.projects.each do |project|
   Payment.create :billable => project, :rate => 20*100
end
