# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.sorted_table').sortable
    containerSelector: 'tbody'
    itemSelector: 'tr'
    placeholder: '<tr class="placeholder"/>'
