require "rails_helper"

describe TrapController do
  render_views
  describe :new do
    it "renders the new template" do
      response.should render_template("new")
    end
    it "new template says 'Add a new endpoint'" do
      response.body.should match /Add a new endpoint/
    end
  end
  describe :show do
    context "when trap exists" do
      begin do
        @trap = create(:trap)
        get "/#{@trap.name}"
      end
      it "returns status ok" do
        response.status.should eq(200)
      end
      it "renders show template" do
        response.should render_template("show")
      end
      context "zero requests" do
        it "template says 'No requests have been received yet'" do
          response.body.should match /No requests have been received yet/
        end
      end
      context "received requests" do
        it "displays trap" do
          response.should render_template("new")
        end
      end
    end
    context "when trap does not exist" do
      it "returns status bad request" do
        response.status.should eq(400)
      end
    end
  end
end