ready = ->

  $(window).on "resize load", ->
    $(".js-body-height").height $("body").height()


  $ ->
    $sidebar = $(".l-sidebar")
    $main = $(".l-main")

    $(".js-toggle-sidebar").click ->
      if $sidebar.position().left is 0
        $sidebar.addClass("contract")
        $sidebar.removeClass("expand")
        $main.addClass("expand")
        $main.removeClass("contract")
      else
        $sidebar.addClass("expand")
        $sidebar.removeClass("contract")
        $main.addClass("contract")
        $main.removeClass("expand")


  $ ->
    $('.js-toggle-garage-status').closest('form').on 'ajax:success', ->
      $(this).closest('tr').toggleClass("is-garage-disable");

$(document).ready(ready)
$(document).on('page:load', ready)
