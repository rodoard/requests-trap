class WebSockets
  scheme: "ws://"
  constructor: (websocket_server) ->
    @websocket = new WebSocket("#{@scheme}#{websocket_server}/");
    @
  subscribe: (chanel, event, action) ->
    @websocket.onmessage = (message) ->
      action(message.data)
    @
window.WebSockets = WebSockets