###
  Resizes the height of the sidebar according body
###
$(window).on "resize load", ->
  $(".js-body-height").height $("body").height()

###
  Hide or show the sidebar when you click on the menu button
###
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
