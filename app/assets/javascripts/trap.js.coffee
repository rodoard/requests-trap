class Trap
  fieldSetCollapse: ->
    $('legend').click ->
      $(this).parent().find('.content').slideToggle("slow")
  collapsible: (request) =>
    "<fieldset>#{request}</fieldset>"
  onNewRequest: (request) =>
    $("#new-requests .content").prepend @collapsible(request)
  requests: ->
    self = @
    $("tr.response a").click (event)->
      event.stopPropagation()
      $(this).parent().find('fieldset').toggle()
    @fieldSetCollapse()
    websocket_params = $("#websocket_params").val()
    websocket = new window.WebSockets(websocket_params)
    websocket.subscribe("requests", "new", self.onNewRequest)

window.Trap = Trap