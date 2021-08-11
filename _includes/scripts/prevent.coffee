$("a.prevent-default").on "click", (e) -> e.preventDefault()
$("form.prevent-default").on "submit", (e) -> e.preventDefault()
{%- capture api -%}
## Prevent default

Prevent default events for links and forms with a `.prevent-default`{:.language-sass} class.
{%- endcapture -%}