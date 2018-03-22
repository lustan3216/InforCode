FactoryGirl.define do
  factory :client do
    title {Faker::Name.name}
    telephone {Faker::PhoneNumber.phone_number}
    ad_impression_price 0.1
    ad_click_price 3
    ad_face_price 1
  end
end