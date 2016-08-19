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
  $('#comment_post').on 'click', (event) ->
    url = $('#new_comment').attr('action')
    method = 'post'
    $.ajax
      url: url
      dataType: 'json'
      method: method
      data: {content: $('#comment_content').val(), product_id: $('#comment_product_id').val()}
      success: (data) ->
        console.log data.result
        if data.result
          strVar = "<div class=\"col-xs-6\">";
          strVar += "<div class=\"panel panel-default arrow left\">";
          strVar += "<div class=\"panel-body\">";
          strVar += "<header class=\"text-left\">";
          strVar += data.user;
          strVar += "<\/header>";
          strVar += "<hr>";
          strVar += "<div class=\"comment-post\">";
          strVar += "<p>"+data.content+"<\/p>";
          strVar += "<\/div>";
          strVar += "<\/div>";
          strVar += "<\/div>";
          strVar += "<\/div>";
          $('.product_comment_total').append(strVar)
