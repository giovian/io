notification = (text, cls) ->
  # Create notification SPAN
  span = $('<span/>', {datetime: new Date(), text: text})
  dateTime span
  # Create DIV and append elements to overlay
  div = $('<div/>', {class: "#{if cls then "color-#{cls}" else 'bg-secondary'} p-around border-inline"})
  $('#notifications').empty().append(div.append span)
  # Timer to fade and expire
  div.delay(3000).fadeOut('slow', -> div.remove())
  # Output in console
  console.log [text, cls || 'default', new Date()].join ', '
  return # end notification
{%- capture api -%}
## Notification

Render a notification on the navigation bar with custom text, color and elapsed time on hover.

The notification will be shown on console as well.

```coffee
notification('text', 'color')
```

**Options**

- `text`: text to show
- `color`: added as class with prepended `.color-`{:.language-sass}.  
  Default to `.bg-secondary`{:.language-sass}
{%- endcapture -%}