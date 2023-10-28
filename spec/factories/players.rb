FactoryBot.define do
  factory :player do
    association :team
    name { Faker::Name.name }
    gender { Player.genders.keys.sample }
  end
end
