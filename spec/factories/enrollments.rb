FactoryGirl.define do
  factory :enrollment do
    association :user
    association :group
  end
end
