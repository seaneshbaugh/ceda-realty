FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "#{Faker::Internet.user_name}#{n}"
    end

    email do
      Faker::Internet.email
    end

    password '0123456789'

    password_confirmation do
      password
    end

    role 'read_only'

    first_name do
      Faker::Name.first_name
    end

    last_name do
      Faker::Name.last_name
    end

    trait :agent do
      role 'agent'
    end

    trait :admin do
      role 'admin'
    end

    trait :sysadmin do
      role 'sysadmin'
    end

    factory :agent, traits: [:agent]

    factory :admin, traits: [:admin]

    factory :sysadmin, traits: [:sysadmin]
  end
end
