# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('body').on "click", ".edit", () ->
    $('.sorted_table').sortable("disable")
  
  $('body').on "click", ".save_item", () ->
    $('.sorted_table').sortable("enable")

  $('body').on "click", ".cancel_item", () ->
    $('.sorted_table').sortable("enable")
