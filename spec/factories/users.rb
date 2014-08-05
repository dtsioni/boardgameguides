# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name     "Daniel"
    email    "daniel@example.com"
    password "foobar"
    password_confirmation "foobar"
    role "test"
  end
end