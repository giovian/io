---
order: 1
---

# Customization

* toc
{:toc}

- **FAVICON** `/assets/images/favicon.ico`
- **SASS** `/assets/css/stylesheet.sass`

```sass
---
---
// Override default variabiles here
@import io
// Override CSS rules here
```

## Colors

`class="color-blue"`{:.language-css}  
`$colors: (blue: DodgerBlue, red: Red, green: LimeGreen, orange: Orange, pink: Fuchsia)`{:.language-sass}

<div class="grid">
{%- assign colors = "blue,green,red,orange,pink" | split: "," -%}
{% for color in colors %}
<div class="p-around rounded color-{{ color }}">
  Example {{ color }} <span class="fg-secondary">secondary text</span>
  <div class="p-around m-vh bg-secondary rounded">Secondary background</div>
  and <a href="#">Link</a>
</div>
{% endfor %}
</div>

## Footer

The FOOTER include the 3 files in `_includes/page/footer`:

| File | Default content |
|---|---|
| `left.html` | GitHub links |
| `center.html` | empty |
| `right.html` | Link to page-top |

To override these defaults add any of theese files to your repository with customized content.

## Tables

<table>
  <thead>
    <tr>
      <th colspan=6>Colors</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>code</code></td>
      {% for color in colors %}
        <td class="color-{{ color }}">.color-{{ color }}</td>
      {% endfor %}
    </tr>
    {% for color in colors %}
      <tr class="color-{{ color }}">
        <td colspan=6>.color-{{ color }} <code>code</code></td>
      </tr>
    {% endfor %}
  </tbody>
</table>