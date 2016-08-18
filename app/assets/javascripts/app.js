(function() {
  $(document).on('ready page:load', function() {
    $('.flash-message').delay(5000).fadeOut(300)
    $("#sliders").simpleSlider({ speed: 500 });
  });
}).call(this);
