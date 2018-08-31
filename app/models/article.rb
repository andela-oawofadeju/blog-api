class Article < ApplicationRecord
  #model association
  belongs_to :user
  #vaildations
  validates_presence_of :title, :post
end
