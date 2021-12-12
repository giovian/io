# Ajax prefilter
$.ajaxPrefilter (options, ajaxOptions, request) ->

  # Never cache
  options.cache = false

  # Fail function
  request.fail (request, status, error) -> notification "#{status}: #{request.status} #{request.responseJSON?.message || error}", 'red'

  # Check request url
  if options.url.startsWith '{{ site.github.api_url }}'
    # Check personal token
    if login.storage()["token"]
      # Set GitHub headers
      options.headers =
        "Authorization": "token #{login.storage()['token']}"
        "Accept": "application/vnd.github.v3+json"
    else
      options.headers = { "Accept": "application/vnd.github.v3+json" }

  return # end Prefilter

{%- capture api -%}
## Ajax prefilter

Remove cache for ajax requests and set `Accept` and `Authorization` headers for request to GitHub API.
{%- endcapture -%}