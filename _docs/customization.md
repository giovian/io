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

The theme is set in the `_config.yml` file with the value `css.theme`, default to `dark`.

```yml
# _config.yml
css:
  theme: light
```

Theme list: `dark`, `light`

## Sass

The theme {% include widgets/github_link.html path='_sass/default/_variabiles.sass' text='variabiles' %} can be overridden in the (empty) file `_sass/variabiles.sass`.  

To create a new theme, add a file `_sass/theme-name.sass`. To change only the color scheme, include in the file the colors and lightness variabiles and `@import default`{:.language-sass}.

Custom sass can be included in the (empty) file `_sass/custom.sass`.

## Colors

Color variations are defined in the theme file, along with the link color.
```sass
$link-color: DodgerBlue
$colors: (blue: DodgerBlue, red: Red, green: LimeGreen, orange: Orange, pink: Fuchsia)
```
For every colors there are five shades defined in the lightness SASS list for background, foreground, secondary background and foreground and borders.
```sass
$lightness: (bg: 4%, fg: 83%, bg_secondary: 9%, fg_secondary: 57%, border: 21%)
```

Colors are appied to elements with the classes `.color-(blue/red/green/orange/pink)`.
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

## Syntax highlight

Syntax highlight theme is set in the `_config.yml` file with the value `css.syntax`, default to `rouge/molokai_custom`.

```yml
# _config.yml
css:
  syntax: rouge/github
```

Possible themes are in {% include widgets/github_link.html path='_sass/syntax' %}. 

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

{% include widgets/api.html include='page/navigation' %}
{% include widgets/api.html include='page/footer' %}

## Tables

Default TABLES have a border, rounded corners and shaded headers. A class color can be applied on rows or cells.

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
  <tbody>
    <tr>
      <td colspan=6>New body</td>
    </tr>
  </tbody>
</table>