$ ->
  console.log "Subscribing "
  window.faye = new Faye.Client('http://localhost:9292/faye')
  window.faye.logLevel = "debug"
  window.faye.subscribe "/games", (data) ->
    console.log(data)
    eval(data)


