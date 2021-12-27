notification = (code, cls, persist = false) ->
  # Create notification SPAN
  span = $('<span/>').append code
  color_class = "#{if cls then "color-#{cls}" else 'bg-secondary'}"
  $('#notification').empty().addClass(color_class).append span
  # Timer to fade and expire
  if persist then return
  span.delay(3000).fadeOut 'slow', ->
    span.remove()
    $('#notification').removeClass color_class
    return # End fadeout delay
  return # end notification
{%- capture api -%}
## Notification

Render a notification on the navigation bar with custom text, color and elapsed time on hover.

The notification will be shown on console as well.

```coffee
notification('text', 'color')
```

**Arguments**

- `text`: text to show
- `color`: added as class with prepended `.color-`{:.language-sass}.  
  Default to `.bg-secondary`{:.language-sass}
{%- endcapture -%}