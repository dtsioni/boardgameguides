# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do  
  
  factory :user do
    sequence(:name) { |n| "example_user_#{n}" }
    sequence(:email) { |n| "email_#{n}@example.com" }        
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