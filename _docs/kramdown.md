---
order: 2
---

# Kramdown

* toc
{:toc}

## Code

<div class="grid">
{%- assign code_files = 'fenced,liquid,kramdown,indented' | split: "," -%}
{% for code in code_files %}{% include code/{{ code }}.html %}{% endfor %}
</div>
