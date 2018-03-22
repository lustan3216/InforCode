namespace :fake do

  task build: %i[admin clients users signage_category containers shops signage signages_category managers campaigns ad_groups ads]

  task admin: :environment do
    puts('create admin')

    Admin.create(email: '@gmail.com', password: '123123123',password_confirmation: '123123123')
    p Admin.all.size
  end

  task clients: :environment do
    puts('create clients')

    @client = Client.create(title: Faker::Name.title, description: Faker::Lorem.sentence)
    @client_id = @client.id
    p Client.all.size
  end

  task users: :environment do
    puts('create users')

    20.times do
      password = Faker::Internet.password
      User.create(email: Faker::Internet.email, password: password,password_confirmation: password)
    end

    user_1 = User.find_by_email('iiiiiii@gmail.com')
    if user_1
      user_1.update(client_id: @client_id)
    else
      User.create(email: 'iiiiiii@gmail.com', password: '123123123',password_confirmation: '123123123', client_id: @client_id)
    end

    user_2 = User.find_by_email('service@iiiiiii.com')
    if user_2
      user_2.update(client_id: @client_id)
    else
      User.create(email: 'service@iiiiiii.com', password: 'Iloveiiiiiii',password_confirmation: 'Iloveiiiiiii', client_id: @client_id)
    end
    p User.all.size
  end

  task containers: :environment do
    puts('create container')

    Container.all.delete_all
    30.times do
      Container.create(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence,
        client_id: @client_id
      )
    end
    p Container.all.size
  end

  task shops: :environment do
    puts('create shops')

    Shop.all.delete_all
    50.times do
      Shop.create(title: Faker::Lorem.sentence,
                  description: Faker::Lorem.sentence,
                  country: Faker::Address.country,
                  zipcode: Faker::Address.zip_code,
                  city: Faker::Address.city,
                  district: Faker::Address.street_name,
                  address1: Faker::Address.street_address + Faker::Address.secondary_address,
                  telephone: Faker::PhoneNumber.phone_number,
                  client_id: @client_id)
    end
    p Shop.all.size
  end

  task signage: :environment do
    puts('create signage')

    Signage.all.delete_all
    30.times do
      Signage.create(
        title: Faker::Lorem.sentence,
        number: 12312123123,
        client_id: @client_id,
        shop_id: Shop.all.ids.sample,
        container_id: Container.ids.sample
      )
    end
    p Signage.all.size
  end

  task signage_category: :environment do
    puts('create signage_category')

    SignageCategory.all.delete_all
    5.times do
      SignageCategory.create(title: Faker::Address.latitude, number: Faker::Address.longitude)
    end
    p SignageCategory.all.size
  end

  task signages_category: :environment do
    puts('create signages_category')

    SignagesCategory.all.delete_all
    50.times do
      SignagesCategory.create(signage_id: Signage.ids.sample, signage_category_id: SignageCategory.ids.sample)
    end
    p SignagesCategory.all.size
  end

  task managers: :environment do
    puts('create managers')

    Manager.all.delete_all
    5.times do
      password = Faker::Internet.password
      Manager.create(email: Faker::Internet.email,
                     password: password,password_confirmation: password,
                     client_id: @client_id,
                     name: Faker::Name.title)
    end
    p Manager.all.size
  end

  task campaigns: :environment do
    puts('create campaign')

    Campaign.all.delete_all
    5.times do
      Campaign.create(client_id: @client_id,
                      manager_id: Manager.ids.sample,
                      name: Faker::Name.title)
    end
    p Campaign.all.size
  end

  task ad_groups: :environment do
    puts('create ad_groups')

    AdGroup.all.delete_all
    25.times do
      AdGroup.create(client_id: @client_id,
                     campaign_id: Campaign.ids.sample,
                     name: Faker::Name.title)
    end
    p AdGroup.all.size
  end

  task ads: :environment do
    puts('create ads')

    Ad.all.delete_all
    80.times do
      Ad.create(client_id: Client.last.id,
                manager_id: Manager.ids.sample,
                campaign_id: Campaign.ids.sample,
                ad_group_id: AdGroup.ids.sample,
                name: Faker::Name.title,
                ad_template_id: AdTemplate.ids.sample)
    end
    p Ad.all.size
  end

end
