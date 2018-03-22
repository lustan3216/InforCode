FactoryGirl.define do
  factory :ad_template do
    client
    width 1280
    height 736
    title '1280 * 736'

    trait :sm do
      width 420
      height 320
      title '420 * 320'
    end

    trait :lg do
      width 12800
      height 7360
      title '12800 * 7360'
    end
  end
end