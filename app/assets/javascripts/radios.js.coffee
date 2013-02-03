# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  for t in $('.track')
      $(t).click ->
        console.log 'Dd'
        played_at = $(this).find('.played-at').first()
        played_at.slideToggle()