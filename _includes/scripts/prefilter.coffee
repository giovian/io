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

# Ajax Send wait effect before request
$(document).ajaxSend (options, request, ajaxOptions) ->
  $('html').addClass 'wait'
  console.log [ajaxOptions.type, ajaxOptions.url].join ' '
  return # End ajax Send

{%- capture api -%}
## Ajax prefilter

Remove `cache` for ajax requests and set `Accept` and `Authorization` headers for request to GitHub API.  

Show a notification in case of error.  

Apply Wait and dewait effect to HTML element.
{%- endcapture -%}