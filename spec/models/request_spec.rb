require 'rails_helper'

describe Request do
  it { should belong_to(:trap) }
  it { should validate_presence_of(:cat)}
  it { should validate_presence_of(:data)}
  Request::COLUMNS_REQUIRED.each do |column|
    it { should validate_presence_of(column)}
  end
  it {should have_db_column(:data).of_type(:json)}
end
