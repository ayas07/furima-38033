FactoryBot.define do
  factory :order_delivery do
    post_code         { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    delivery_area_id  { Faker::Number.between(from: 2, to: 48) }
    city              { Faker::Lorem.word }
    address           { Faker::Lorem.word }
    building          { Faker::Lorem.word }
    phone_number      { '0' + Faker::Number.between(from: 100_000_000, to: 9_999_999_999).to_s }
    token             { 'tok_' + Faker::Lorem.characters(number: 28) }
  end
end
