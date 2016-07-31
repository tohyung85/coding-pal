FactoryGirl.define do
  factory :group do
    sequence :name do |n|
      "Awesome Group #{n}"
    end
    remote true
    course 'Firehose Project'
    commitment_hours 20
    association :user
  end
end
