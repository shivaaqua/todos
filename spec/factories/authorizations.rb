# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    user_id 1
    provider "MyString"
    uid "MyString"
    email "MyString"
  end
end
