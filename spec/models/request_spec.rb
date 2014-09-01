require 'rails_helper'

describe Request do
  it { should belong_to(:trap) }
  it { should validate_presence_of(:body)}
  it {should have_db_column(:body).of_type(:hstore)}
end
