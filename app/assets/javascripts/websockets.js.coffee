class WebSockets
  constructor: (websocket_server) ->
    @dispatcher = new WebSocketRails(websocket_server)
    @
  subscribe: (chanel, event, action) ->
    chanel = @dispatcher.subscribe(chanel)
    chanel.bind event, action
    @
window.WebSockets = WebSockets