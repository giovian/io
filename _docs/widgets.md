---
order: 3
---

- toc
{:toc}

# Widgets
{:.no_toc}

{% include api/show.html include="widgets/github_url" %}

{% include api/show.html include="widgets/github_link" %}

{% include api/show.html include="widgets/datetime" %}

__Examples__

{% assign now = 'now' | date: "%s" %}
{% assign minute = 60 %}
{% assign hour = minute | times: 60 %}
{% assign day = hour | times: 24 %}
{% assign week = day | times: 7 %}
{% assign month = day | times: 30 %}
{% assign year = week | times: 52 %}
{% assign future_minute = now | plus: minute %}
{% assign future_hour = now | plus: hour %}
{% assign future_day = now | plus: day %}
{% assign future_week = now | plus: week %}
{% assign future_month = now | plus: month %}
{% assign future_year = now | plus: year %}
{% assign past_minute = now | minus: minute %}
{% assign past_hour = now | minus: hour %}
{% assign past_day = now | minus: day %}
{% assign past_week = now | minus: week %}
{% assign past_month = now | minus: month %}
{% assign past_year = now | minus: year %}
**Basic**
- Empty {% include widgets/datetime.html %}
- Embed {% include widgets/datetime.html embed=true %}
- Replace {% include widgets/datetime.html replace=true %}

<div class="grid">
<div markdown=1>
**Future**
- Minute {% include widgets/datetime.html replace=1 datetime=future_minute %}
- Hour {% include widgets/datetime.html replace=1 datetime=future_hour %}
- Day {% include widgets/datetime.html replace=1 datetime=future_day %}
- Week {% include widgets/datetime.html replace=1 datetime=future_week %}
- Month {% include widgets/datetime.html replace=1 datetime=future_month %}
- Year {% include widgets/datetime.html replace=1 datetime=future_year %}
</div>
<div markdown=1>
**Past**
- Minute {% include widgets/datetime.html replace=1 datetime=past_minute %}
- Hour {% include widgets/datetime.html replace=1 datetime=past_hour %}
- Day {% include widgets/datetime.html replace=1 datetime=past_day %}
- Week {% include widgets/datetime.html replace=1 datetime=past_week %}
- Month {% include widgets/datetime.html replace=1 datetime=past_month %}
- Year {% include widgets/datetime.html replace=1 datetime=past_year %}
</div>
</div>

{% include api/show.html include='widgets/notifications' %}

{% include api/show.html include='widgets/toc' %}
