require 'rails_helper'

describe Trap do
  it { should validate_presence_of(:name) }
  context "" do
    before do
      @trap_id = create(:trap).name
      @request = {"body" => "request"}
      Trap.requests(@trap_id).count.should eq(0)
    end
    it "can return received requests" do
      Trap.add_new_request @trap_id, @request
      Trap.requests(@trap_id).first.body.should eq(@request)
    end
    it "can return received requests by type" do
      Trap.add_new_request @trap_id, @request, "put"
      Trap.requests_for(@trap_id, "get").count.should eq(0)
      Trap.requests_for(@trap_id, "put").count.should eq(1)
    end
    it "returns empty array when no requests have been received" do
      result = Trap.requests @trap_id
      result.count.should eq(0)
    end
    it "can add a add_new_request" do
      result = Trap.add_new_request @trap_id, @request
      result.should_not eq(nil)
    end
  end
end
