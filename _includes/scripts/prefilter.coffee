# Ajax prefilter
$.ajaxPrefilter (options, ajaxOptions, request) ->

  # Never cache
  options.cache = false

  # Fail function
  request.fail (request, status, error) -> notification "#{status}: #{request.status} #{request.responseJSON?.message || error}", 'red'

  # Add header options
  if options.url.startsWith '{{ site.github.api_url }}'
    options.headers = {'Accept': 'application/vnd.github.v3+json'}
    # Check personal token
    if login.storage()['token']
      # Add GitHub token
      options.headers['Authorization'] = "token #{login.storage()['token']}"

  # Dewait effect
  request.always -> $('html').removeClass 'wait'

  return # end Prefilter

# Wait effect before request and log request on console
$(document).ajaxSend (options, request, ajaxOptions) ->
  $('html').addClass 'wait'
  console.count [ajaxOptions.type, ajaxOptions.url.split('?')[0]].join ' '
  return # End ajax Send

{%- capture api -%}
## Ajax prefilter

- Remove `cache` for ajax requests
- Set `Accept` and `Authorization` headers for request to GitHub API.
- Show a notification in case of error.
- Apply Wait and dewait effect to HTML element.
- Log request on console
{%- endcapture -%}