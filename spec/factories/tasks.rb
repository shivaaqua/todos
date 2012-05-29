# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title "Automation"
    active true
    deleted_at nil
  end
end
