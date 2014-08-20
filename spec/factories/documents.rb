# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    sequence(:name){ |n| "example_document_#{n}" }
    link "examplelink.com"
    format "Example Format"
    sequence(:user_id){ |n| "#{n}" }
    sequence(:game_id){ |n| "#{n}" }
  end
end
