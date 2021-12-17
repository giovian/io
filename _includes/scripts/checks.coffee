# Refresh page if repository changed
check_build = ->
  latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}'
  latest.done (data) ->
    unixtime = new Date(data.updated_at).getTime() / 1000
    # Compare repository update unixtime and built unixtime
    if unixtime > Number $('meta[name=site_build_unixtime]').attr('content')
      # Update SHA on storage
      storage.assign 'repository', {updated_at_unix: unixtime}
      # Refresh with the new SHA as hash
      short_sha = unixtime
      new_url = location.origin + location.pathname + '?updated_at_unix=' + unixtime + location.hash
      $('#alerts').empty().append "<a href='#{new_url}' title='#{unixtime}'>New build</a>"
    return
  return # end Build check

# Request a new build if remote repository changed
check_remote = ->
  [remote, branch] = $('meta[name=remote_theme]').attr('content').split '@'
  data = if branch then {sha: branch} else {}
  latest = $.get "{{ site.github.api_url }}/repos/#{remote}/commits",
    data: data
  latest.done (data) ->
    # Compare online and stored remote commit SHA
    if data[0].sha isnt storage.get 'repository.remote_sha'
      # Update SHA on storage
      storage.assign 'repository', {remote_sha: data[0].sha}
      # Request a build
      request = $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds",
        method: 'POST'
      request.done (data, status) -> notification "Site build request: <code>#{data.status}</code>"
    return
  return # End Remote check

# Dispatch
checks = ->
  # Check again i 1 or 10 minutes depending on logged or unauthenticated
  minutes = 1
  if $('html').hasClass 'logged'
    # Check remote_theme
    if storage.get('functions.check_remote') and $('meta[name=remote_theme]').attr 'content' then check_remote()
  else minutes = 10
  # check_build
  if storage.get 'functions.check_build' then check_build()
  # Schedule next dispatch
  setTimeout checks, minutes * 60 * 1000
  return # end checks

# Start checks
if '{{ site.github.environment }}' isnt 'development' then setTimeout checks, 60 * 1000
{%- capture api -%}
## Checks

Include the functions `check_build` and (if the site use a remote theme) `check_remote`. The functions can be activated in the Help page.  

`check_build`: every pageload wait 1 minute and compare website `build_revision` SHA with repository latest commit: if they are different, reload the page with the SHA as hash.  

`check_remote`: every pageload wait 1 minute and compare the remote theme latest commit and compare with previous stored SHA: if they are different, request a new pages build.  

Subsequent checks are every 10 minutes for unauthenticated users and every minute for logged ones.  

This script is not active in development: `{%raw%}{{ site.github.environment }}{%endraw%} != development`{:.language-liquid}.
{%- endcapture -%}