class UserMessage < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receipient, class_name: 'User'
end
