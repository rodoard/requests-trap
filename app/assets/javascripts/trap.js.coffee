class Trap
  fieldSetCollapse: ->
    $('legend').click ->
      $(this).parent().find('.content').slideToggle("slow")
  collapsible: (request) =>
    "<fieldset>#{request}</fieldset>"
  onNewRequest: (request) =>
    $("#new-requests .content").prepend @collapsible(request.display)
  requests: ->
    self = @
    $("tr.response a").click (event)->
      event.stopPropagation()
      $(this).parent().find('fieldset').toggle()
    @fieldSetCollapse()
    pusher_params = $("#pusher_params").val()
    pusher = new window.TPusher(pusher_params)
    pusher.subscribe("requests", "new", self.onNewRequest)

window.Trap = Trap