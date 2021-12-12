$('[switch-boolean]').each ->
  element = $ @
  [property, value] = element.attr('switch-boolean').split '|'
  if property and value
    sw = if storage.get(property)?[value] then true else false
    option_true = "<option value='true' #{if sw then 'selected'}>True</option>"
    option_false = "<option value='false' #{if !sw then 'selected'}>False</option>"
    select = $("<select class='inline'></select>").append [option_true, option_false]
    select.on 'change', (e) ->
      obj = storage.get(property) || {}
      if e.target.value is 'true' then obj[value] = true else delete obj[value]
      storage.set property, obj
      notification "#{property} #{value} set to <strong>#{e.target.value}</strong>", 'green'
      return
    element.empty().text("#{property} #{value}: ").append select
  return
{%- capture api -%}
## Switch

Manage boolean switches of a `value` in the browser local storage `property`. It is an HTML element with a `switch` attribute in the format `property|value`.

```html
<span switch-boolean='property|value'><span>
```

Will inject a select element with `True` and `False` options: the selected option is saved in the `storage`.
{%- endcapture -%}