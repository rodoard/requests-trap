require "rails_helper"

describe HomeController do
  before do
    get :splash
  end
 it "should render splash page" do
   response.should render_template("splash")
 end
end