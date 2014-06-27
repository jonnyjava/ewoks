ready = ->

  $(window).on "resize load", ->
    $(".js-body-height").height $('body').height()

  $ ->
    $(".js-toggle-sidebar").click ->
        $(".l-main").toggleClass("contract")

$(document).ready(ready)
$(document).on('page:load', ready)
