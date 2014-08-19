# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do 

  factory :game do
    sequence(:name) { |n| "example_game_#{n}" }
    body "Example description of game"
    sequence(:user_id) { |n| "#{n}" }
  end

end
