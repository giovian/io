---
order: 2
---

# Kramdown
{:.no_toc}

* toc
{:toc}

## Table of contents

Render an ordered or unordered nested list (with default ID `markdown-toc`) of the headers by assigning it an Inline Attribute List (IAL) with reference name `toc`.
```md
* toc or 1. toc
{:toc}
```

Exclude headers from the TOC with the class `no_toc`.
```md
## Excluded header
{: .no_toc}
```

Check [toc widget]({{ 'docs/widgets#table-of-contents' | absolute_url }}) to change the position of the toc.

## Code

<div class="grid">
{%- assign code_files = 'fenced,liquid,kramdown,indented' | split: "," -%}
{% for code in code_files %}{% include code/{{ code }}.html %}{% endfor %}
</div>
