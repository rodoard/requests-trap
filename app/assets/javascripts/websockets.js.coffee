class WebSockets
  constructor: (websocket_server) ->
    @dispatcher = new WebSocketRails(websocket_server, false)
    @
  subscribe: (chanel, event, action) ->
    chanel = @dispatcher.subscribe(chanel)
    chanel.bind event, action
    @
window.WebSockets = WebSockets