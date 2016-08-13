FactoryGirl.define do
  factory :message do
    message_title 'Group announcement'
    message_description 'Let us have fun'
    association :user
    association :group
  end
end
