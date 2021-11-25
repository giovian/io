wait = (form) ->
  if form
    form.find(":input").prop "disabled", true
    form.addClass "wait"
  $('html').addClass "wait"
  return

dewait = (form) ->
  if form
    form.find(":input").prop "disabled", false
    form.removeClass "wait"
  $('html').removeClass "wait"
  return

{%- capture api -%}
## Wait

Apply or remove `.wait`{:.language-css} class to HTML and an optional FORM.

```js
wait(form); // form is optional
dewait(form); // form is optional
```
{:.minimal}
{%- endcapture -%}