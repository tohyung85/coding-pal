class JoinRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: 'User'
  belongs_to :group
end
