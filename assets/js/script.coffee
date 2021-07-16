---
---
# Prevent default events
$("a.prevent-default").on "click", (e) -> e.preventDefault()
$("form.prevent-default").on "submit", (e) -> e.preventDefault()

# Fix inline <code> element without class
$(':not(pre) code').addClass 'highlight'

# Ajax prefilter
$.ajaxPrefilter (options) ->
  # Check request url
  if options.url.startsWith '{{ site.github.api_url }}'
    # Check personal token
    if login.storage()["token"]
      # Set GitHub headers
      options.headers = {
        "Authorization": "token #{login.storage()['token']}"
        "Accept": "application/vnd.github.v3+json"
      }
    else
      options.headers = { "Accept": "application/vnd.github.v3+json" }
  return

# Include scripts
{% include scripts/toc.coffee %}
{% include scripts/apply_family.coffee %} # Apply classes to parents/childrens
{% include scripts/datetime.coffee %}     # Use apply_family
{% include scripts/notification.coffee %} # Use datetime
{% include scripts/storage.coffee %}
{% include scripts/login.coffee %}        # Use notification, apply_family, storage
{% include scripts/details.coffee %}      # Use storage
{% include scripts/custom.coffee %}       # Custom file (empty by default)