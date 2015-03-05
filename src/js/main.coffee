document.addEventListener 'DOMContentLoaded', (event) ->
  # console.log 'DOM Loaded & Parsed'
  # asdf =
  #   'var1': 'valor1'
  #   'var2':
  #     'subvar2_1': 'asdf'
  #     'subvar2_2': 'zxcv'

  # dest = document.getElementById 'dest'
  # for idx in document.querySelectorAll('#index li a')
  #   idx.addEventListener "click", (e) ->
  #     Ajax.load @href, dest
  #     e.preventDefault()
  # alerx 1

  for gal in document.querySelectorAll('.caruso')
    caruso = new Caruso(gal)
  true

  # pelis = Ajax.jsonPost 'http://localhost:8000/'
  # , 'PageSize=6&Page=1&FieldSet=basic&SearchCondition={"suscriptionLevel": 1, "device": "PC", "filter": {"category": "peliculas", "genre": "terror"}}'
  # ,(xhr) ->
  #   console.log xhr.response
  #, {'Timestamp': 1425492662, 'Signature': '18cdbf8649fc8e7acde3e91d33db7cd10451cbfe'}

# vim:set ts=2 sw=2 et:
