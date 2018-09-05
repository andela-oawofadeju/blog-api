class Article < ApplicationRecord
  #model association
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true
  #vaildations
  validates_presence_of :title, :post, :authorized_by
end
