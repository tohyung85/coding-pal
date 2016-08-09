FactoryGirl.define do
  factory :join_request do
    association :group
    association :requestor, factory: :user
    message 'let me join!'
  end
end
