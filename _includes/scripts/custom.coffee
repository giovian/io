$ ->
  console.log $().jquery || 'no'
  $('form').each -> console.log @