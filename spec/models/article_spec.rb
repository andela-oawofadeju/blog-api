require 'rails_helper'

RSpec.describe Article, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:post) }
end
