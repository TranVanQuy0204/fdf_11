$(document).on 'ready page:load', ->
  $('#checkout_address').on 'click', (event) ->
    url = '/address'
    method = 'PUT'
    $.ajax
      url: url
      dataType: 'json'
      method: method
      data: {address: $('#_address').val()}
      success: (data) ->
        console.log data.result
        if data.result
          $('#checkout_finish').removeClass('hidden')
          $('.step-2-checkout-address').html(data.value)
        else
          $('.notification-checkout').removeClass('hidden')
