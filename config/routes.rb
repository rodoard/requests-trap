Rails.application.routes.draw do
  root 'home#splash'
  match '/:trap_id', to: 'trap#handle_request', via: :all
  match '/:trap_id/request/:id', to:'trap#trap_request', via: :get, as: "trap_request"
  match '/:trap_id/requests', to:'trap#requests', via: :get
end
