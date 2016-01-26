# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".price_select").on "change", () ->
    total_raw_price = 0
    $(".price_select").each () ->
      ticket_id = $(this).data("ticket-id")
      price = parseInt($(this).data("ticket-price"))
      amount = $(this).val()
      ticket_raw_price = amount * price
      #collecting raw price for all chosen tickets
      total_raw_price += ticket_raw_price
    if total_raw_price == 0
      $("#total_raw_price").html("Price: 0.00")
      $("#fee").html("Fee: 0.00")
      $("#total_price").html("Total: 0.00")
    else
      #calculating price with your own fee(2.5% + 1 dollar)
      price_with_fee = total_raw_price + (total_raw_price * 0.025 + 0.99)
      #calculating total price with stripes fee(2.9% + 30 cents)  
      total_price = price_with_fee + (price_with_fee * 0.029 + 0.30)
      #calculating total fee
      fee = total_price - total_raw_price
      $("#total_raw_price").html("Price: " + total_raw_price.toFixed(2))
      $("#fee").html("Fee: " + fee.toFixed(2))
      $("#total_price").html("Total: " + total_price.toFixed(2))