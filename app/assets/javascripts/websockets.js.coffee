class WebSockets
  constructor: (websocket_server) ->
    @dispatcher = new WebSocketRails("localhost:3000/websocket")
    @
  subscribe: (chanel, event, action) ->
    chanel = @dispatcher.subscribe(chanel)
    chanel.bind event, action
    @
window.WebSockets = WebSockets