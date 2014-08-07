# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@example.com"
  end
  sequence :name do |n|
    "example_user_#{n}"
  end
  factory :user do
    name
    email
    password "password"
    password_confirmation "password"
    role "author"
  end

  factory :admin, parent: :user do
    role "admin"
  end

  factory :moderator, parent: :user do
    role "moderator"
  end

end