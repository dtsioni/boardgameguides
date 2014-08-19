# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guide do
    sequence(:name) { |n| "example_guide_#{n}" }
    body "Example description of guide"
    format "Example format of guide"
    link "examplelinkofguide.com"
    sequence(:user_id) {|n| "#{n}" }
    sequence(:game_id) {|n| "#{n}" }
  end
end
