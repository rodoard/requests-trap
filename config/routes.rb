Rails.application.routes.draw do
  root 'home#splash'
  match '/:trap_id', to: 'trap#handle_request', via: :all
end
