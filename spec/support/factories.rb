FactoryGirl.define do
  factory :entity do
    sequence(:name)   { |n| "name_#{n}" }
    sequence(:status) { |n| "status_#{n}" }
  end
end

