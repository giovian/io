# Ajax prefilter
$.ajaxPrefilter (options) ->
  options.cache = false
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
{%- capture api -%}
## Ajax prefilter

Set `Accept` and `Authorization` headers for request to GitHub API.
{%- endcapture -%}