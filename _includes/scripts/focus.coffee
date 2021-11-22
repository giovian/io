focus = true
window.onfocus = -> focus = true
window.onblur = -> focus = false
{%- capture api -%}
## Focus

Boolean variabile `focus` indicate browser page focus status.

```cs
if focus
  // window is focused
else
  // window is blurred
```
{:.minimal}
{%- endcapture -%}