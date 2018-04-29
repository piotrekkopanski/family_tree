class Parent < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: User
end
