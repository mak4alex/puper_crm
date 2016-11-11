[ { name: 'Belorusian ruble', abbr: 'BYN' },
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

def deal
  price = Faker::Commerce.price.to_f
  promo_price = price - price * 0.1
  {
    currency_id: Currency.ids.sample,
    promo: '10%',
    name: Faker::Commerce.product_name,
    sku: Faker::Code.asin,
    unit_type: Deal::UNIT_TYPES.values.sample,
    unit_price: price,
    promo_unit_price: promo_price,
    description: Faker::Hipster.sentence,
    start_at: Time.now,
    end_at: Time.now + 1.year,
    accepted: [true, false].sample,
    probability: (rand * 100).round(2)
  }
end

10.times do
  ClientDeal.create!(deal)
  SupplierDeal.create!(deal)
end

Deal.all.each do |deal|
  deal.plans.each do |plan|
    plan.values.each do |value|
      value.value = (rand * 100).round(2)
      value.set_at = Time.now
      value.save!
    end
  end
end

def offer(type)
  {
    deal_id: type == 'client' ? ClientDeal.ids.sample : SupplierDeal.ids.sample,
    agent_id: type == 'client' ? Client.ids.sample : Supplier.ids.sample,
    sent_at: Time.now,
    responded_at: nil
  }
end

10.times do
  ClientOffer.create!(offer('client'))
  SupplierOffer.create!(offer('supplier'))
end
