# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :ticket do
    sequence(:name) { |n| "example_ticket_#{n}" }
    body "This is the body of an example ticket"
    fulfilled false
    status "Example status"
  end

  factory :fulfilled_ticket, parent: :ticket do
    fulfilled true
  end
  
end
