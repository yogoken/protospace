FactoryGirl.define do
  factory :user do
    password = Faker::Internet.password(8)
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password password
    password_confirmation password
  end
end
