class Ajax
  # static method
  @load: (url, dest, loading = 'Cargando…') ->
    xhr = new XMLHttpRequest()
    if 'string' == typeof obj
      dest = document.getElementById dest
    xhr.onreadystatechange = ->
      dest.innerHTML = xhr.responseText
    xhr.open 'GET', url, true
    xhr.send ''
    false

  @jsonPost: (url, parameters, callback = null) ->
    xhr = new XMLHttpRequest()
    xhr.open 'POST', url, true
    xhr.responseType = 'json'
    xhr.setRequestHeader 'Content-type', 'application/x-www-form-urlencoded'
    xhr.setRequestHeader 'Content-length', parameters.length
    xhr.setRequestHeader 'Connection', 'close'
    if callback
      xhr.onreadystatechange = ->
        if xhr.readyState == 4 && xhr.status == 200
          callback xhr
    xhr.send parameters
    xhr

  @getCb: (url, cb) ->
    xhr = new XMLHttpRequest()
    xhr.onreadystatechange = ->
      cb(xhr) if xhr.readyState == 4
    xhr.open 'GET', url, true
    xhr.send ''
    xhr

root = exports ? this
root.Ajax = Ajax
# vim:set ts=2 sw=2 et:
