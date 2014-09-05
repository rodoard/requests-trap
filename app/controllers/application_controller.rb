class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :define_host_with_port
  private
  def define_host_with_port
    @host_with_port = request.host_with_port
  end
end
