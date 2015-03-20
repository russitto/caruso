class Caruso
  movement: 'auto'
  flagAjaxFree: true
  moreItemsUrl: '/xhr-html.html?'+Math.random()
  moreItemsCallback: ->
    @moreItemsUrl = '/xhr-html.html?'+Math.random()

  constructor: (@elem) ->
    elem = @elem
    if @movement == 'auto'
      @movement = elem.querySelectorAll('.item')[0].offsetWidth

    left = elem.querySelectorAll '.left'
    right = elem.querySelectorAll '.right'
    scrollable = elem.querySelectorAll '.viewport'
    container = elem.querySelectorAll '.horizontal'
    thiss = this
    selff = @constructor

    window.onresize = ()->
      thiss.fixLengths()

    if scrollable.length
      scrollable[0].addEventListener 'scroll', (e) ->
        scroll = scrollable[0].scrollLeft

        if scrollable[0].scrollLeft + scrollable[0].offsetWidth >= container[0].offsetWidth - 100
          thiss.moreItems()

        if scroll <= 0
          scroll = 0
          selff.hide left[0]
        else
          selff.show left[0]

        if (scrollable[0].scrollLeft + scrollable[0].offsetWidth) >= container[0].offsetWidth
          selff.hide right[0]
        else
          selff.show right[0]

      #scrollable[0].dispatchEvent new Event('scroll')

      if left.length
        # supongo que es uno solito
        left[0].addEventListener 'click', (e) ->
          e.preventDefault()
          e.stopPropagation()
          if left[0].disabled
            return false

          scroll = scrollable[0].scrollLeft - thiss.movement
          scrollable[0].scrollLeft = scroll
          thiss.show right[0]
      if right.length
        # supongo que es uno solito
        right[0].addEventListener 'click', (e) ->
          e.preventDefault()
          e.stopPropagation()
          if right[0].disabled
            return false

          scroll = scrollable[0].scrollLeft + thiss.movement
          scrollable[0].scrollLeft = scroll

  moreItems: ->
    # si el moreItemsUrl es vacío entonces no hago mas pedidos
    return false if @moreItemsUrl == ''

    elem = @elem
    right = elem.querySelectorAll '.right'
    container = elem.querySelectorAll '.horizontal'
    thiss = this
    selff = @constructor
    #oldCount = elem.querySelectorAll('.item').length

    if container.length
      if @flagAjaxFree
        @flagAjaxFree = false
        Ajax.getCb @moreItemsUrl, (xhr) ->
          selff.loading right[0].children[0]
          if xhr.response != ''
            container[0].innerHTML += xhr.response
            #count = elem.querySelectorAll('.item').length
            #thiss.fixLengths(count/oldCount)
            thiss.fixLengths()
            selff.loading right[0].children[0], false
            selff.show right[0]
            thiss.moreItemsCallback() if thiss.moreItemsCallback
            thiss.flagAjaxFree = true
            true
          else
            false

  fixLengths: ->
    elem = @elem
    container = elem.querySelectorAll '.horizontal'
    elems = elem.querySelectorAll '.item'
    count = elems.length
    if container.length and count
      screenW = document.documentElement.clientWidth
      if screenW >= 768
        itemsPerPage = 5
      else if screenW >= 480
        itemsPerPage = 4
      else
        itemsPerPage = 3

      w = 100/count
      margin = 6/count
      totalW = 100*count/itemsPerPage
      container[0].style.width = totalW + "%"
      for item in elems
        @constructor.show item
        item.style.width = w + "%"

  @show: (elem) ->
    elem.className = elem.className.replace(/(?:^|\s)disabled(?!\S)/g , '')
    elem.disabled = false
  @hide: (elem) ->
    elem.disabled = true
    elem.className += " disabled"

  @loading: (elem, state = true) ->
    if state
      elem.innerHTML = '…'
    else
      elem.innerHTML = '»'

root = exports ? this
root.Caruso = Caruso
# vim:set ts=2 sw=2 et:
