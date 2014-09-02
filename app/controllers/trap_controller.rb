class TrapController < ApplicationController
  def new
    @trap = Trap.new
  end
  def create
  end
  def handle_request
    success = false
    begin
      success = Trap.add_new_request params[:trap_id], request
    rescue
    end
    status = success ? 200 : 400
    render json: {success: success}, status: status
  end
end
