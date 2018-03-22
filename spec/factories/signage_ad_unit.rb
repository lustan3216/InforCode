FactoryGirl.define do
  factory :signage_ad_unit do
    client
    ad_template
    title 'test'

    trait :script do
      mode '1'
    end

    trait :random do
      mode '0'
    end
  end
end