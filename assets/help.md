---
title: Help
permalink: help/
sidebar: []
---
{% include page/init.html %}
# Help

**Repository**
- <https://github.com/{{ gh.repository_nwo }}>
- Owner type `{{ repo.owner.type }}`
- Page type `{% if gh.is_user_page %}User{% endif %}{% if gh.is_project_page %}Project{% endif %}`
- Created {% include widgets/datetime.html datetime=repo.created_at replace=true %}
- Modified {% include widgets/datetime.html datetime=repo.modified_at replace=true %}
- Sha `{{ gh.build_revision | slice: 0, 7 }}`
- Version `{% include version.html %}`
- Release `{{ gh.releases | first | map: 'tag_name' | default: '-' }}`
{% if site.remote_theme %}

**Remote**
- Theme <{{ site.remote_theme | split: '@' | first | prepend: 'https://github.com/' }}>
{% endif %}

**Auth**
<ul>
  <li><span apply-if-parent='hidden|html:not(.logged)'>Logged as <span apply-if-parent='hidden|html:not(.role-admin)'>admin</span><span apply-if-parent='hidden|html:not(.role-guest)'>guest</span></span><span apply-if-parent='hidden|.logged'>Not logged</span></li>
  {% include widgets/login.html %}
</ul>
<div apply-if-parent='hidden|html:not(.role-admin)'>
  <strong>Builds</strong>
  <ul github-api-url='repos/pages/builds/latest' github-api-text='Latest' github-api-out='status, created_at, duration'></ul>
  <strong>Request a build</strong>
  <ul github-api-url='repos/pages/builds' github-api-method='POST' github-api-out='status'></ul>
</div>
<strong>Functions</strong>
<ul>
  <li switch-boolean='functions|check_build'></li>
  <li apply-if-parent='hidden|html:not(.role-admin)' switch-boolean='functions|check_remote'></li>
</ul>
