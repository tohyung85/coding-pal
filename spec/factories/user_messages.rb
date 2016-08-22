FactoryGirl.define do
  factory :user_message do
    message_title 'Hi Buddy!'
    message_description 'Let us code together '
    association :sender, factory: :user
    association :receipient, factory: :user
  end
end
