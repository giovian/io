notification = (text, cls) ->
  if $('#notification').length
    $('#notification').attr 'open', ''
    color = if cls then "color-#{cls}" else 'bg-secondary'
    # Create notification SPAN
    span = $('<span/>', {datetime: new Date(), text: text})
    # Activate countdown/countup
    dateTime span
    # Append DIV with classes and SPAN
    $('#notification').append $('<div/>', {
        class: "#{color} p-around m-vh rounded"
      }).append span
  else
    # Output to console
    console.log text, color
  return