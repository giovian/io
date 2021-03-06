# Delays larger than 2,147,483,647 ms (about 24.8 days) will result in the timeout being executed immediately.
dateTime = (e) ->

  # Settings
  names = 'second, minute, hour, day, week, month, year'.split(',')
  second = 1000
  minute = second * 60
  hour = minute * 60
  day = hour * 24
  week = day * 7
  month = day * 30.42
  year = week * 52.14
  diff = new Date().getTime() - (new Date(Date.parse $(e).attr "datetime").getTime())
  absolute = Math.abs diff

  # Past or Future
  $(e).removeClass 'past future'
    .addClass if diff > 0 then 'past' else 'future'

  # Define functions
  s = (value) -> if value > 1 then 's' else ''
  get_value = (unit) -> Math.round absolute / unit

  switch
    when !get_value second
      moment = "now"
      update = second
    when absolute < minute
      value = get_value second
      moment = "#{value} second#{s value}"
      update = second
      apply_family()
    when absolute < hour - minute
      value = get_value minute
      moment = "#{value} minute#{s value}"
      update = minute
    when absolute < day
      value = get_value hour
      moment = "#{value} hour#{s value}"
      update = minute
    when absolute < week * 2
      value = get_value day
      moment = "#{value} day#{s value}"
      update = day
    when absolute < week * 3.5
      value = get_value week
      moment = "#{value} week#{s value}"
      update = day
    when absolute < year - month
      value = get_value month
      moment = "#{value} month#{s value}"
      update = day
    else
      value = get_value year
      moment = "#{value} year#{s value}"
      update = day

  # `in/ago` function
  out = (moment) ->
    if moment is "now" then "now" else if diff > 0 then "#{moment} ago" else "in #{moment}"

  # Embed or add title attribute
  if $(e).attr "embed"
    $(e).attr "title", (i, t) -> t || $(e).text()
    $(e).text "#{$(e).attr 'original-text'} (#{out moment})"
  else if $(e).attr "replace"
    $(e).attr "title", (i, t) -> t || $(e).text()
    $(e).text out moment
  else
    $(e).attr "title", out moment

  # Return a setTimeout function
  setTimeout dateTime, update, e
  
  return # end dateTime

$("[datetime]").each -> dateTime @
{%- capture api -%}
## Datetime

Update an element with `datetime` attribute showing a countdown or countup.  

Countdown and countup can replace the element text, be appended or appear on hover (tooltip).  

Element will have an updated class `future` or `past`.

```js
span = $("<span/>", {
  datetime: new Date(),
  text: text
})
dateTime(span)
```

**Options**

- `datetime`: the datetime, default "now"
- `time`: hour time in the for "hh:mm" or "hh:mm:ss"
- `text`: text to show, default is datetime in the form yyyy-mm-ddThh:mm:ss+hh:mm
- `title`: title attribute on hover, default to datetime in the form yyyy-mm-ddThh:mm:ss+hh:mm
- `embed`: append countdown or countup to the text
- `replace`: will replace the date with countdown/countup
{%- endcapture -%}