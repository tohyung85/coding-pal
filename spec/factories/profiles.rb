FactoryGirl.define do
  factory :profile do
    sequence :user_name do |n|
      'John Doe #{n}'
    end
    remote_ok? true
    association :user
  end
end
