if 'IntersectionObserver' of window# and in_view?
  intersectionObserver = new IntersectionObserver (entries) ->
    entries.forEach (entry) ->
      id = entry.target.id
      in_view = entry.isIntersecting
      ele = $("a[href*=#{id}]")
      if in_view then ele.addClass 'inview' else ele.removeClass 'inview'
      return
    return

  # start observing
  $('h2').each -> intersectionObserver.observe @