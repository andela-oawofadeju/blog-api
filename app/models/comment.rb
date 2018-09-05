class Comment < ApplicationRecord
  #model associations
  belongs_to :article, foreign_key: :article_id
  #validations
  validates_presence_of :name, :content
end
