---
order: 1
---

# Customization
{:.no_toc}

* toc
{:toc}

## Favicon

The favicon file is `assets/images/favicon.ico`.  
Replace the file and open in the browser with this [link]({{ 'assets/images/favicon.ico' | absolute_url }}) to update in the browser cache.

## Theme

The theme is set in the `_config.yml` file with the value `css.theme`, default to `io`.

```yml
# _config.yml
css:
  theme: io
```

Theme list: `io`, `basic`

## Syntax highlight

Syntax highlight theme is set in the `_config.yml` file with the value `css.syntax`, default to `rouge/molokai_custom`.

```yml
# _config.yml
css:
  syntax: rouge/github
```

Possible themes are on {% include widgets/github_link.html path='_sass/syntax' %}.

## Sass

The theme {% include widgets/github_link.html path='_sass/io/_variabiles.sass' text='variabiles' %} can be overridden in the file {% include widgets/github_link.html path='_sass/variabiles.sass' %}.  

Custom sass can be included in the file {% include widgets/github_link.html path='_sass/custom.sass' %}. 

## Sidebar

The main page content has an optional sidebar which use `flex`.

```html
<div class="wrapper">
  <aside><!-- Sidebar --></aside>
  <section><!-- Page content --></section>
</dov>
```

To choose sidebar side add `$sidebar-side: left/right`{:.language-sass} in the {% include widgets/github_link.html path='_sass/variabiles.sass' %} file (default is right).

The sidebar will be populated with widgets included in the folder `_includes/widgets/`.

Select the widgets with a YAML array `sidebar: [...]`{:.language-yml}:

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

To add custom content, create a `_includes/widgets/sidebar.html` file and include in the array: `sidebar: [sidebar]`{:.language-yml}

If the sidebar is empty (no widgets) it will collapse `flex: 0`{:.language-sass}.  

## Colors

Colors are defined in a SASS list.
```sass
$colors: (blue: DodgerBlue, red: Red, green: LimeGreen, orange: Orange, pink: Fuchsia)
```
Are appied to elements with the class `.color-blue/red/green/orange/pink`.
<div class="grid">
{%- assign colors = "blue,green,red,orange,pink,default" | split: "," -%}
{% for color in colors %}
<div class="p-around rounded color-{{ color }}">
  Example {{ color }} <span class="fg-secondary">secondary text</span>
  <div class="p-around mvh bg-secondary rounded">Secondary background</div>
  and <a href="#">Link</a>
</div>
{% endfor %}
</div>

{% include widgets/api.html include='page/footer' %}

## Tables

Default TABLES have a border, rounded corners and shaded header. A class color can be applyed on rows or cells.

{% assign colors = "blue,green,red,orange,pink" | split: "," %}
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