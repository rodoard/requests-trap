require "rails_helper"

describe HomeController do
  before do
    get '/'
  end
 it "should render template splash" do
   response.should render_template("splash")
 end
end