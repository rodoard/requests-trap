class TPusher
  
  constructor: (app_key) ->
    @pusher = new Pusher(app_key)
    @

  subscribe: (chanel, event, action) ->
    @pusher.subscribe(chanel).bind(event, action)
    @

window.TPusher = TPusher