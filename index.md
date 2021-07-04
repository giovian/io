---
---

# Home

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Datetime

Render a SPAN element with _x time ago_ or _in x time_ format

```liquid
{% raw %}{% include widgets/datetime.html datetime="..." %}{% endraw %}
```

Optional attributes

- `embed` will append countdown or countup to the date
- `replace` will replace the date with countdown/countup
- `time` will add a time to date in the format `00:00:00`
- `text` text to show
- `title` title attribute on hover

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

**Future**
- Minute {% include widgets/datetime.html replace=1 datetime=future_minute %}
- Hour {% include widgets/datetime.html replace=1 datetime=future_hour %}
- Day {% include widgets/datetime.html replace=1 datetime=future_day %}
- Week {% include widgets/datetime.html replace=1 datetime=future_week %}
- Month {% include widgets/datetime.html replace=1 datetime=future_month %}
- Year {% include widgets/datetime.html replace=1 datetime=future_year %}

**Past**
- Minute {% include widgets/datetime.html replace=1 datetime=past_minute %}
- Hour {% include widgets/datetime.html replace=1 datetime=past_hour %}
- Day {% include widgets/datetime.html replace=1 datetime=past_day %}
- Week {% include widgets/datetime.html replace=1 datetime=past_week %}
- Month {% include widgets/datetime.html replace=1 datetime=past_month %}
- Year {% include widgets/datetime.html replace=1 datetime=past_year %}