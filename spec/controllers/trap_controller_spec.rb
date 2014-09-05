require "rails_helper"

module TrapHelper
  def self.http_verbs_do
    [:get, :patch, :head, :put, :delete, :post].each do |verb|
      yield(verb.to_s)
    end
  end
  def send_request(verb, trap_id)
    send verb, "/#{@trap_id}"
  end
  def requests_for(trap_id, type)
    Trap.requests_for(trap_id, type)
  end
  def trap_requests(trap_id)
    get :requests, :trap_id => trap_id
  end
  def trap_request(trap_id, request_id)
    get :trap_request, :trap_id => trap_id, :id => request_id
  end
  def add_request(trap_id)
    Trap.add_new_request @trap_id, build(:request), {success:true}, "get"
  end
end
describe TrapController, :type => :request do
  include TrapHelper
  before do
    @trap_id = build(:trap).name
  end
  context "captures requests at endpoint" do
    TrapHelper.http_verbs_do do |verb|
      it "invokes add_new_request for #{verb.upcase}" do
        Trap.should receive(:add_new_request)
        send_request verb, "/#{@trap_id}"
      end
    end
    TrapHelper.http_verbs_do do |verb|
      it "for #{verb.upcase}" do
        requests_for(@trap_id, verb).count.should eq(0)
        send_request verb, "/#{@trap_id}"
        requests_for(@trap_id, verb).count.should eq(1)
      end
    end
  end
  context "responds with correct http code if success or not" do
    context "happy path" do
      TrapHelper.http_verbs_do do |verb|
        it "#{verb.upcase} response returns with status 200" do
          send_request verb, "/#{@trap_id}"
          response.status.should eq(200)
        end
      end
    end
    context "error path" do
      before do
        allow_any_instance_of(TrapController).to receive(:handle_request).and_raise(StandardError)
      end
      TrapHelper.http_verbs_do do |verb|
        it "#{verb.upcase} response returns with status 400" do
          send_request verb, "/#{@trap_id}"
          response.status.should eq(400)
        end
      end
    end
  end
end
describe TrapController do
  render_views
  include TrapHelper
  before do
    @trap_id = build(:trap).name
  end
  context "received requests" do
    before do
      trap_request = add_request @trap_id
      @request_id = trap_request.id
    end
    context "display single request" do
      before do
        trap_request @trap_id, @request_id
      end
      it "includes trap id in header" do
        response.body.should have_tag('h2', :text => @trap_id.titleize )
      end
      context "request has" do
        it "a header with id" do
          response.body.should have_tag('div.header', :text => "Request: #{@request_id}" )
        end
        it "a body" do
          response.body.should have_tag('div.body')
        end
        it "and response" do
          response.body.should have_tag('div.response')
        end
      end
     end
    context "display all requests" do
      before do
        trap_requests @trap_id
      end
      it "includes trap id in header" do
        trap_requests @trap_id
        response.body.should have_tag('h2', :text => @trap_id.titleize )
      end
      it "displays a table" do
        response.body.should have_tag('table.requests')
      end
      context "a request has" do
        it "a request-header with link to request" do
          response.body.should have_tag("tr.request-header-#{@request_id}") do
            with_tag('a', with: {href: "/#{@trap_id}/request/#{@request_id}"},  text: "Request #{@request_id}")
          end
        end
        it "a request-body" do
          response.body.should have_tag("tr.request-body-#{@request_id}")
        end
        context "a request-response " do
          it " with a link to view response" do
            response.body.should have_tag("tr.request-response-#{@request_id}") do
              with_tag('a', with: {href: "#response-#{@request_id}"},  text: "Response")
            end
          end
          it " that is initially hidden" do
            response.body.should have_tag("tr.request-response-#{@request_id}") do
              with_tag('fieldset', with: {class: "hidden"})
            end
          end
        end
      end
    end
   end
    context "0 requests" do
      it "displays no requests have been received" do
        trap_requests @trap_id
        no_request_received = "No requests have been received."
        response.body.should have_tag('p', :text => no_request_received )
      end
    end
end