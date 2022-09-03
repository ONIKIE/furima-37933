FactoryBot.define do
  factory :purchase_address do
    user_id { Faker::Number.non_zero_digit }
    product_id { Faker::Number.non_zero_digit }
    postal_code { '777-7777' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { Gimei.address.city.kanji }
    address { Gimei.address.town.kanji }
    phone_number { '00000000000' }
    building_name { Faker::Address.street_address }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
