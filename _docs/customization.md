---
order: 1
---

# Customization
{:.no_toc}

* toc
{:toc}

## Favicon

The favicon file is `assets/images/favicon.ico`.  
Replace the file and open in the browser with this [link]({{ 'assets/images/favicon.ico' | absolute_url }}) to update.

## Theme and styles

The theme is set in the `_config.yml` file with the value `css.theme`, default to `io`.

```yml
# _config.yml
css:
  theme: io
```

Theme list: `io`, `basic`

The theme **{% include widgets/github_link.html path='_sass/io/_variabiles.sass' text='variabiles' %}** can be overridden in the file {% include widgets/github_link.html path='_sass/variabiles.sass' %}

**Custom CSS rules** can be added in the file {% include widgets/github_link.html path='_sass/custom.sass' %}

**Syntax highlight** is set in the `_config.yml` file with the value `css.syntax`, default to `rouge/molokai`.

```yml
# _config.yml
css:
  syntax: rouge/github
```

## Sidebar

The main page content has an optional sidebar which use `flex`.


```html
<div class="wrapper">
  <aside><!-- Sidebar --></aside>
  <section><!-- Page content --></section>
</dov>
```

Default position is right (`flex-direction: row-reverse;`{:.language-css}), for a right sidebar add `$sidebar_flex_direction: row`{:.language-css} in the {% include widgets/github_link.html path='_sass/variabiles.sass' %} file.

The sidebar will be populated with widgets included in the folder `_includes/widgets/`.

Select the widgets with a YAML array `sidebar: [...]`{:.language-yml} for the relative pages:

<div class="grid">
<div markdown="1">
For every page

```yml
# _config.yml
defaults:
  - scope:
      path: ""
    values:
      sidebar: [...]
```
</div>
<div markdown="1">
For pages in collections

```yml
# _config.yml
defaults:
  - scope:
      type: my-collection
    values:
      sidebar: [...]
```
</div>
</div>

For singular pages, in the _front-matter_

```yml
---
sidebar: [...]
---
```

If the sidebar is empty (no widgets) it will collapse `flex: 0`{:.language-sass}

## Colors

`class="color-blue"`{:.language-sass}  
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

{% include api/show.html include='page/footer' %}

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