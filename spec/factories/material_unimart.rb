FactoryGirl.define do
  factory :material do
    manager
    ad_template
    name 'test'

    trait :file_complete do
      trigger_file { Rack::Test::UploadedFile.new(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png') }
      display_file { Rack::Test::UploadedFile.new(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png') }
    end

    trait :file_incomplete do
      display_file { Rack::Test::UploadedFile.new(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png') }
    end
  end
end