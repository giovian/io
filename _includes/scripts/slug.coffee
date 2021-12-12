slug = (string) -> 
  return string.toString().toLowerCase().trim()
  .replace /[^\w\s-]/g, ''
  .replace /[\s_-]+/g, '_'
  .replace /^-+|-+$/g, ''

unslug = (string) ->
  out = "#{string}".replace /[_-]/g, ' '
  return out.charAt(0).toUpperCase() + out.slice 1