[
  { name: 'Belorusian ruble', abbr: 'BYN' },
  { name: 'Euro', abbr: 'EUR' },
  { name: 'Dollar USA', abbr: 'USD' }
].each do |currency|
  Currency.create!(currency)
end


def worker
  {
    full_name: Faker::Name.name,
    position: Faker::Name.title,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    skype: Faker::Hipster.word,
    fax: Faker::PhoneNumber.cell_phone
  }
end

10.times do
  Contact.create!(worker)
  Manager.create!(worker)
end


def agent
  name = Faker::Company.name
  company_name = name + ' ' + Faker::Company.suffix
  {
    name: name,
    company_name: company_name,
    delivery_time: Time.now,
    contact_id: Contact.ids.sample,
    manager_id: Manager.ids.sample
  }
end

10.times do
  Client.create!(agent)
  Supplier.create!(agent)
end

def deal(type)
  if type == ClientDeal
    agent_id = Client.ids.sample
  elsif type == SupplierDeal
    agent_id = Supplier.ids.sample
  else
    raise 'Not supported deal type'
  end
  price = Faker::Commerce.price.to_f
  {
    agent_id: agent_id,
    currency_id: Currency.ids.sample,
    promo: '10%',
    name: Faker::Commerce.product_name,
    sku: Faker::Code.asin,
    unit_type: ['kg', 'unit', 'l'],
    unit_price: price,
    promo_unit_price: price - price * 0.1,
    description: Faker::Hipster.sentence,
    sent_at: Time.now,
    responded_at: Time.now
  }
end

20.times do
  ClientDeal.create!(deal(ClientDeal))
  SupplierDeal.create!(deal(SupplierDeal))
end


40.times do
  Plan.create!({
    name: Plan::NAMES.sample,
    step: Plan::STEPS.sample,
    start_at: Time.now,
    end_at: Time.now,
    deal_id: Deal.ids.sample,
    accepted: [true, false].sample,
    probability: rand * 100
  })
end

200.times do
  Value.create!({
    value: rand * 10_000,
    plan_id: Plan.ids.sample
  })
end
