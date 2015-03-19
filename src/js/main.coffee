document.addEventListener 'DOMContentLoaded', (event) ->
  for gal in document.querySelectorAll('.caruso')
    caruso = new Caruso(gal)
    caruso.moreItemsUrl = '/xhr-html.html?zzzz='+Math.random()
    caruso.moreItemsCallback = () ->
      @moreItemsUrl = '/xhr-html.html?asdf='+Math.random()
  true

# vim:set ts=2 sw=2 et:
