class TrapController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from  StandardError, with: :return_failed
  def handle_request
    render json: {success: true}, status: 200
  end
  def trap_request
    #load_trap
    #@trap_request = @trap.requests.find params[:id]
  end
  def requests
    load_trap
    @requests = @trap.requests
  end
  private
  def load_trap
    @trap = Trap.find_or_create_trap params[:trap_id]
  end
  protected
  def return_failed(exception)
    logger.error exception.message
    render json: {success: false}, status: 400
  end



end
