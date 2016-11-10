$(document).on 'turbolinks:load', ->
  $('#save_deal_values').click ->
    $('#values').submit()
