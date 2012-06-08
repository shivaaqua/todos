$ ->
  $("div.signin-form button.register-btn").click ->
    location.href = "/signup"
    
  $("div#alert-message a").click ->
    $("div#alert-message").fadeOut 300
