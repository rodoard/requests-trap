require 'spec_helper'

describe Request do
  it { should belong_to(:trap) }
  it { should validate_presence_of(:body) }
end
