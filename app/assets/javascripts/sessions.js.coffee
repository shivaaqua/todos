$ ->
  $("div.signin-form button.register-btn").click ->
    location.href = "/signup"
    
  $("div#alert-msg a").click ->
    $("div#alert-msg").fadeOut 300
