
class NotWebSocketConstraint
  def self.matches?(request)
    request.env["action_dispatch.request.path_parameters"][:trap_id] != 'websocket'
  end
end

Rails.application.routes.draw do
  root 'home#splash'
  match '/:trap_id', to: 'trap#handle_request', via: :all, constraints: NotWebSocketConstraint
  match '/:trap_id/request/:id', to:'trap#trap_request', via: :get, as: "trap_request"
  match '/:trap_id/requests', to:'trap#requests', via: :get
end
