FactoryBot.define do
  factory :user do
    nickname { "tanaka" }
    email { "t@t" }
    password { "qwert1234" }
    password_confirmation { "qwert1234" }
    last_name { "た" }
    first_name { "た" }
    last_name_kana { "タ" }
    first_name_kana { "タ" }
    birth_date { Faker::Date.birthday }
  end
end
