---
order: 2
---

# Kramdown
{:.no_toc}

* toc
{:toc}

## Table of contents

Render an ordered or unordered nested list (with default ID `markdown-toc`) of the headers in the page.  

Add an Inline Attribute List (IAL) with reference name `toc` to a one element ordered or unordered list.
```md
* toc or 1. toc
{:toc}
```

Exclude headers from the TOC with the class `no_toc`.
```md
## Excluded header
{: .no_toc}
```

Check [toc widget]({{ 'docs/widgets#table-of-contents' | absolute_url }}) to put the TOC in the sidebar.

## Code

<div class="grid">
{%- assign code_files = 'fenced,liquid,kramdown,indented' | split: "," -%}
{% for code in code_files %}{% include code/{{ code }}.html %}{% endfor %}
</div>
