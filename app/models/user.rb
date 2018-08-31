class User < ApplicationRecord
  #validation
  validates_presence_of :name, :email
  #model association
  has_many :articles, dependent: :destroy
end
