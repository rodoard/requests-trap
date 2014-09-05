class Trap
  requests: ->
    $("tr.response a").click (event)->
      event.stopPropagation()
      $(this).parent().find('fieldset').toggle()
window.Trap = Trap