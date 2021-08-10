notification = (text, cls) ->
  color = if cls then "color-#{cls}" else 'bg-secondary'
  if $('#widget-notifications').length
    $('#widget-notifications').attr 'open', ''
    # Create notification SPAN
    span = $('<span/>', {datetime: new Date(), text: text})
    # Activate countdown/countup
    dateTime span
    # Append DIV with classes and SPAN
    $('#widget-notifications').append $('<div/>', {
        class: "#{color} p-around mvh rounded"
      }).append span
  else
    # Output to console
    console.log "#{text}, #{color}, #{new Date()}"
  return # end notification
{%- capture api -%}
## Notification

Render a notification inside the notifications widget with custom text, color and countdown/countup on hover.

If the widget is not present the notification will be shown on console.

```coffee
notification('text', 'color')
```

**Options**

- `text`: text to show
- `color`: added as class with prepended `.color-`{:.language-sass}.  
  Default to `.bg-secondary`{:.language-sass}
{%- endcapture -%}