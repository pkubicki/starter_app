# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:login) {|n| "login#{n}" }
    sequence(:email) {|n| "email#{n}@example.com"}
    password "Secret123"
  end
end
