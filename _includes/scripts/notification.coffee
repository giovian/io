notification = (text, cls) ->
  if $('#notification').length
    $('#notification').attr 'open', ''
    color = if cls then "color-#{cls}" else 'bg-secondary'
    span = $('<span/>', {datetime: new Date(), text: text})
    dateTime span
    $('#notification').append $('<div/>', {
        class: "#{color} p-around m-vh rounded"
      }).append span
  else
    console.log text, color
  return