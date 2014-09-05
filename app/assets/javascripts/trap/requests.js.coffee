jQuery ->
  $("tr.response a").click (event)->
    event.stopPropagation()
    $(this).parent().find('fieldset').toggle()