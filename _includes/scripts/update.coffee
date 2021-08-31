update = -> setTimeout check_update, 60 * 1000

check_update = ->

  if true #"{{ site.github.environment }}" is "dotcom"

    # Check again i 1 or 10 minutes depending on logged or unauthenticated
    if $('html').hasClass 'logged' then timer = 60 * 1000 else timer = 10 * 60 * 1000
    setTimeout check_update, timer

    # GET repository sha
    latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits'

    latest.done (data) ->
      # Compare online and built repository commit SHA
      if data[0].sha is $('meta[name=repository_sha]').attr('content')
        notification 'Build is updated', 'green'
      else
        # Refresh no cache
        location.reload true

      return # end ajax done

    #latest.fail (request, status, error) -> notification "#{status}, #{error}", 'red'

  return # end check_update

{%- capture api -%}
## Update

Every pageload wait 1 minute and compare website build_revision SHA with repository latest commit: if they are different, reload the page without cache.  

Subsequent checks are every 10 minutes for unauthenticated users and evry minute for logged ones.  

Active only in production: `{%raw%}{{ site.github.environment }}{%endraw%}`{:.language-liquid} is `dotcom`.
{%- endcapture -%}