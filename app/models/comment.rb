class Comment < ApplicationRecord
  #model associations
  belongs_to :article
  #validations
  validates_presence_of :name, :content
end
