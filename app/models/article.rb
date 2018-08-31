class Article < ApplicationRecord
  #model association
  has_many :comments
  belongs_to :user
  #vaildations
  validates_presence_of :title, :post
end
