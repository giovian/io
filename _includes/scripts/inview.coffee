inview_default = {
  in:
    element: 'h2'
    attribute: 'id'
  out:
    element: '#markdown-toc a'
    attribute: 'href'
}
observe = (inview, options = {}) ->
  $.extend inview_default, inview
  if 'IntersectionObserver' of window
    callback = (entries) ->
      entries.forEach (entry) ->
        attribute = $(entry.target).attr inview.in.attribute
        in_view = entry.isIntersecting
        ele = $("#{inview.out.element}[#{inview.out.attribute}*=#{attribute}]")
        if in_view then ele.addClass 'inview' else ele.removeClass 'inview'
        return # end entries loop
      return # end callback

    # start observing
    $(inview.in.element).each -> new IntersectionObserver(callback, options).observe @

  return # end observe

{%- capture api -%}
## In view

Observer for elements inside viewport.
```cs
observe(inview, options)
```

Will check if an `inview.in.element` is inside the viewport and apply an `.inview`{:.language-sass} class to the `inview.out.element` whom `inview.out.attribute` contains `inview.in.attribute`.

**Default `inview` object**
```js
inview = {
  in:
    element: "h2"
    attribute: "id"
  out:
    element: "#markdown-toc a"
    attribute: "href"
}
```
If a table of contents is present, when an `h2` title is inside the viewport, the corresponding TOC link will have an `.inview`{:.language-sass} class.

**Default `options` object**
```js
options = {
  root: document.body
  rootMargin: "0px"
  threshold: 1.0
}
```
{%- endcapture -%}