class User < ApplicationRecord
  #encrypt password
  has_secure_password

  #validation
  validates_presence_of :name, :email, :password_digest

  #model association
  has_many :articles, foreign_key: :authorized_by
end
