require "rails_helper"

module TrapHelper
  def self.http_verbs_do
    [:get, :put, :delete, :post].each do |verb|
      yield(verb)
    end
  end
end
describe TrapController, :type => :request do
  def requests_for(trap_id, type)
    Trap.requests_for(trap_id, type)
  end
  before do
    @trap_id = build(:trap).name
  end
  context "captures requests at endpoint" do
    TrapHelper.http_verbs_do do |verb|
      it "invokes add_new_request for #{verb.upcase}" do
        Trap.should receive(:add_new_request)
        send verb, "/#{@trap_id}"
      end
    end
    TrapHelper.http_verbs_do do |verb|
      it "#{verb.upcase}" do
        requests_for(@trap_id, verb).count.should eq(0)
        send verb, "/#{@trap_id}"
        requests_for(@trap_id, verb).count.should eq(1)
      end
    end
  end
  context "responds with correct http code if success or not" do
    context "happy path" do
      TrapHelper.http_verbs_do do |verb|
        it "#{verb.upcase} response returns with status 200" do
          send verb, "/#{@trap_id}"
          response.status.should eq(200)
        end
      end
    end
    context "error path" do
      before do
       Trap.should receive(:add_new_request).and_raise(StandardError)
      end
      TrapHelper.http_verbs_do do |verb|
        it "#{verb.upcase} response returns with status 400" do
          send verb, "/#{@trap_id}"
          response.status.should eq(400)
        end
      end
    end
  end
end