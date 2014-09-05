controller_action = ->
  jQuery ->
    controller = $('body').data('controller')
    action = $('body').data('action')
    if window[controller]
      controller = new window[controller]
      if controller[action]
        controller[action]()

window.controller_action = controller_action