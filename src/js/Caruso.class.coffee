class Caruso
  @movement: 80

  constructor: (elem) ->
    # scrollbar fix

    left = elem.querySelectorAll('.left')
    right = elem.querySelectorAll('.right')
    scrollable = elem.querySelectorAll('.viewport')

    if scrollable.length
      if left.length
        # supongo que es uno solito
        left[0].addEventListener 'click', (e) ->
          scroll = scrollable[0].scrollLeft - Caruso.movement
          if scroll <= 0
            scroll = 0
            Caruso.hide this
          else
            Caruso.show this
          scrollable[0].scrollLeft = scroll
          Caruso.show right[0]
          e.preventDefault()
      if right.length
        # supongo que es uno solito
        right[0].addEventListener 'click', (e) ->
          scroll = scrollable[0].scrollLeft + Caruso.movement
          scrollable[0].scrollLeft = scroll
          if scroll > scrollable[0].scrollLeft
            Caruso.hide this
          else
            Caruso.show this
          Caruso.show left[0]
          e.preventDefault()

  @show: (elem) ->
    elem.style.display = 'block'
  @hide: (elem) ->
    elem.style.display = 'none'

root = exports ? this
root.Caruso = Caruso
# vim:set ts=2 sw=2 et:
