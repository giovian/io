$("a.prevent-default").on "click", (e) ->
  e.preventDefault()
  return
$("form.prevent-default").on "submit", (e) ->
  e.preventDefault()
  return
{%- capture api -%}
## Prevent default

Prevent default events for links and forms with a `.prevent-default`{:.language-sass} class.
{%- endcapture -%}