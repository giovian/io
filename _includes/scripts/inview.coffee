inview_default = {
  in:
    element: 'h2'
    attribute: 'id'
  out:
    element: '#markdown-toc a'
    attribute: 'href'
}
observe = (inview = inview_default) ->
  if 'IntersectionObserver' of window
    intersectionObserver = new IntersectionObserver (entries) ->
      entries.forEach (entry) ->
        attribute = $(entry.target).attr inview.in.attribute
        in_view = entry.isIntersecting
        ele = $("#{inview.out.element}[#{inview.out.attribute}*=#{attribute}]")
        if in_view then ele.addClass 'inview' else ele.removeClass 'inview'
        return # end entries loop
      return # end intersectionObserver

    # start observing
    $(inview.in.element).each -> intersectionObserver.observe @
  return # end observe
{%- capture api -%}
## In view

Observer for elements inside viewport.  

Will check if an `in.element` is inside the viewport and apply an `.inview`{:.language-sass} class to the `out.element` whom `out.attribute` contains `in.attribute`.

```cs
// Call observe function with default argument
observe()
```

Default argument

```cs
{
  in:
    element: "h2"
    attribute: "id"
  out:
    element: "#markdown-toc a"
    attribute: "href"
}
```
If a table of contents is present, when an `h2` title is inside the viewport, the corresponding TOC link will have an `.inview`{:.language-sass} class.
{%- endcapture -%}