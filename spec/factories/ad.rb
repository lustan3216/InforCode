FactoryGirl.define do
  factory :ad do
    client
    manager
    ad_template
    sequence(:name) { |n| "Ad-#{n}" }

    clicks 0
    faces 0
    impressions 0

    impression_price 0.1
    click_price 3
    face_price 1

    daily_cost 0
    daily_budget 0
    is_default false

    start_at { Time.current - 1.days }
    end_at { Time.current + 10.days }

    trait :default do
      is_default true
    end

    trait :eligible do
      status 'eligible'
    end

    trait :paused do
      status 'paused'
    end

    trait :limited_by_money do
      status 'limited_by_money'
    end

    trait :pending do
      status 'pending'
      start_at { Time.current + 1.days }
    end

    trait :budget_enough do
      daily_cost 0
      daily_budget 100
    end

    trait :budget_not_enough do
      daily_cost 1000
      daily_budget 100
    end

    trait :file_complete do
      after(:create) do |ad|
        ad.materials << FactoryGirl.create(:material, :file_complete)
      end
    end

    trait :file_incomplete do
      after(:create) do |ad|
        ad.materials << FactoryGirl.create(:material, :file_incomplete)
      end
    end

    trait :ad_template_sm do
      ad_template {create(:ad_template, :sm)}
    end
  end
end