---
title: Help
permalink: help/
sidebar: []
---
{%- include page/init.html -%}
# Help
<div class="grid">
  <div markdown="1">
**Repository**
- <https://github.com/{{ gh.repository_nwo }}>
- Owner type `{{ repo.owner.type }}`
- Page type `{% if gh.is_user_page %}User{% endif %}{% if gh.is_project_page %}Project{% endif %}`
- Created {% include widgets/datetime.html datetime=repo.created_at replace=true %}
- Modified {% include widgets/datetime.html datetime=repo.modified_at replace=true %}
- Sha `{{ gh.build_revision | slice: 0, 7 }}`
- Release `{{ gh.releases | first | map: 'tag_name' | default: '-' }}`
{% if site.remote_theme %}

**Remote**
- Theme <{{ site.remote_theme | split: '@' | first | prepend: 'https://github.com/' }}>
- Version `{% include version.html %}`
- Plugin <https://github.com/benbalter/jekyll-remote-theme> {{ site.github.versions["jekyll-remote-theme"] }}
{% endif %}

**Auth**
<ul>
  <li><span apply-if-parent='hidden|html:not(.logged)'>Logged as <span apply-if-parent='hidden|html:not(.role-admin)'>admin</span><span apply-if-parent='hidden|html:not(.role-guest)'>guest</span></span><span apply-if-parent='hidden|.logged'>Not logged</span></li>
  {% include widgets/login.html %}
</ul>
  </div>
  <div markdown="1">
{% if site.github.environment == 'dotcom' %}<div apply-if-parent='hidden|html:not(.role-admin)' markdown="1">
**Builds**
<ul github-api-url='repos/pages/builds/latest' github-api-text='Latest' github-api-out='status, created_at'></ul>
**Request a build**
<ul github-api-url='repos/pages/builds' github-api-method='POST' github-api-out='status'></ul>
</div>
**Functions**
<ul>
  <li switch-boolean='functions|check_build'></li>
  {% if site.remote_theme %}<li apply-if-parent='hidden|html:not(.role-admin)' switch-boolean='functions|check_remote'></li>{% endif %}
</ul>{% endif %}
  </div>
</div>