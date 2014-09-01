require 'rails_helper'

describe Trap do
  it { should validate_presence_of(:name) }
end
