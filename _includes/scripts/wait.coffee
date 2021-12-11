wait = (element) ->
  if $(element)
    $(element).attr "disabled", true
    $(element).find(":input").prop "disabled", true
    $('html').addClass "wait"
  $('html').addClass "wait"
  return

dewait = (element) ->
  if $(element)
    $(element).removeAttr "disabled"
    $(element).find(":input").prop "disabled", false
    $(element).removeClass "wait"
  $('html').removeClass "wait"
  return

{%- capture api -%}
## Wait

Apply or remove `.wait`{:.language-css} class to HTML and an optional ELEMENT.

```js
wait(element);
dewait(element);
```
{:.minimal}
{%- endcapture -%}