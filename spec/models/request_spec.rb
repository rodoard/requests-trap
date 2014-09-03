require 'rails_helper'

describe Request do
  it { should belong_to(:trap) }
  it { should validate_presence_of(:data)}
  it { should validate_presence_of(:cat)}
  it {should have_db_column(:data).of_type(:json)}
end
