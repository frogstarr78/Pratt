module SeedData
  def load_seed_data
    Customer.delete_all
    customer = Customer.create(
      :name         => 'Scott Noel-Hemming',
      :company_name => 'Frogstarr78 Software',
      :address      => '312 NW 7th',
      :phone        => '509.730.5401',
      :zip          => '97862'
    ) 

    Project.delete_all
    Project.create(
    [
      {
        :name => 'Refactor',
        :weight => 1,
        :customer => customer
      },
      {
        :name => 'Lunch/Break',
        :weight => 0,
        :customer => customer
      },
      {
        :name => 'Other',
        :weight => -1,
        :customer => customer
      }
    ]
    )
  end
end
