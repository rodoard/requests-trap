class TrapController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from  StandardError, with: :return_failed
  def handle_request
    render json: {success: true}, status: 200
  end
  protected
  def return_failed
    render json: {success: false}, status: 400
  end
end
