require 'rails_helper'

describe Trap do
  it { should validate_presence_of(:name) }
  def add_new_request(type=nil)
    if type
      Trap.add_new_request @trap_id, @request, @response, type
    else
      Trap.add_new_request @trap_id, @request, @response
    end
  end
  context "" do
    before do
      @trap_id = create(:trap).name
      @noexist = "#{@trap_id}-no-exist"
      @request = build(:request)
      @response = {"response" => "response"}
      @data = {"body" => @request, "response" => @response}
    end
    it "can return received requests" do
      add_new_request
      Trap.requests(@trap_id).first.data.should eq(@data)
    end
    it "can return received requests by type" do
      add_new_request "put"
      Trap.requests_for(@trap_id, "get").count.should eq(0)
      Trap.requests_for(@trap_id, "put").count.should eq(1)
    end
    context "no received request" do
      it "returns empty array for all requests" do
        result = Trap.requests @noexist
        result.count.should eq(0)
      end
      it "returns empty array for requests by type" do
        result = Trap.requests_for @noexist, "patch"
        result.count.should eq(0)
      end
    end
    it "can add a add_new_request" do
      result = add_new_request
      result.should_not eq(nil)
    end
  end
end
