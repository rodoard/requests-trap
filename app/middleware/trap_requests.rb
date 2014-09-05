class TrapRequests
  KEEPALIVE_TIME = 15 # in seconds
  def initialize(app)
    @app = app
    @clients = []
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)

      # WebSockets logic goes here
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
      ws.on :open do |event|
        @clients << ws
      end
      ws.on :message do |event|
        p [:message, event.data]
        @clients.each {|client| client.send(event.data) }
      end
      ws.on :close do |event|
        p [:close, ws.object_id, event.code, event.reason]
        @clients.delete(ws)
        ws = nil
      end
      # Return async Rack response
      ws.rack_response
    else
      status, headers, response = @app.call(env)
      unless /^\/assets.*/ =~ env['REQUEST_PATH']
        request = Rack::Request.new(env)
        info = request.path_info.split('/')
        info.shift
        if info.length == 1 and info.first != 'new'
          trap_id = request.env["action_dispatch.request.parameters"]['trap_id']
          trap_request = Trap.add_new_request trap_id, request_info(request), response.body, request.request_method
          template = File.read(File.join(Rails.root, "app", "views", "trap", "_request.html.erb"))
          output = Erubis::Eruby.new(template).result(request:trap_request)
          Rails.logger.error @clients.count
          @clients.each {|client| client.send(output) }
        end
      end
      [status, headers, response]
    end
  end
  private
  def request_info(request)
    {
     request_date: Date.today.to_s,
     remote_ip: request.ip,
     request_method: request.request_method,
     scheme: request.scheme,
     query_string: request.query_string,
     query_params: request.env["action_dispatch.request.request_parameters"],
     cookies: request.cookies,
     headers: headers(request.env),
     content_type: request.content_type,
     content_length: request.content_length
    }
  end
  def headers(env)
    env.select {|k,v| k.match("^HTTP.*")}
  end
end