# Refresh page if repository changed
check_build = ->
  latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits'
  latest.done (data) ->
    # Compare online and built repository commit SHA
    if data[0].sha is $('meta[name=repository_sha]').attr 'content'
      notification 'Build is updated', 'green'
    else
      # Update SHA on storage
      storage.assign 'repository', {sha: data[0].sha}
      # Refresh with the new SHA as hash
      new_url = "#{location.origin}#{location.pathname}##{data[0].sha}"
      $('#alerts').append "<a href='#{new_url}'>#{data[0].sha.slice 0, 7}</a>"
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
    if data[0].sha is storage.get 'repository.remote_sha'
      notification 'Remote theme is updated', 'green'
    else
      # Update SHA on storage
      storage.assign 'repository', {remote_sha: data[0].sha}
      # Request a build
      request = $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds",
        method: 'POST'
      request.done -> notification 'New remote version: site build requested'
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
if '{{ site.github.environment }}' is 'dotcom' then setTimeout checks, 60 * 1000
{%- capture api -%}
## Checks

Include the functions `check_build` and (if the site use a remote theme) `check_remote`. The functions can be activated in the Help page.  

`check_build`: every pageload wait 1 minute and compare website `build_revision` SHA with repository latest commit: if they are different, reload the page with the SHA as hash.  

`check_remote`: every pageload wait 1 minute and compare the remote theme latest commit and compare with previous stored SHA: if they are different, request a new pages build.  

Subsequent checks are every 10 minutes for unauthenticated users and every minute for logged ones.  

This script is active only in production: `{%raw%}{{ site.github.environment }}{%endraw%}=dotcom`{:.language-liquid}.
{%- endcapture -%}