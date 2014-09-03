class TrapRequests
  def initialize(app)
    @app = app
  end
  def call(env)
    status, headers, response = @app.call(env)
    info = env['PATH_INFO'].split('/')
    info.shift
    trap_id = env["action_dispatch.request.parameters"]['trap_id']
    if info.length == 1 and info.first != 'new'
      Trap.add_new_request trap_id, request_info(env), response.body, env["REQUEST_METHOD"]
    end
    [status, headers, response]
  end
  private
  def request_info(env)
    {
     request_date: Date.today,
     remote_ip: env["REMOTE_ADDR"],
     request_method: env["REQUEST_METHOD"],
     scheme: env["rack.url_scheme"],
     query_string: env["QUERY_STRING"],
     query_params: env["rack.request.query_hash"],
     cookies: "",
     headers:""
    }
  end
end