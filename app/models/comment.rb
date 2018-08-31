class Comment < ApplicationRecord
  #validations
  validates_presence_of :name, :content
end
