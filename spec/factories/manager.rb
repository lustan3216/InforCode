FactoryGirl.define do
  factory :manager do
    client
    sequence(:email) { |n| "manager-#{n}@gmail.com" }
    sequence(:name) { |n| "manager-#{n}" }
    password '12321313213'
    password_confirmation '12321313213'

    remaining_sum 60000
    daily_cost 100
    daily_budget 0
  end
end