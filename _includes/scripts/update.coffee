update = -> setTimeout check_update, 60 * 1000

check_update = ->

  if "{{ site.github.environment }}" is "dotcom"

    # GET repository sha
    latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits'

    latest.done (data) ->
      # Compare online and built repository commit SHA
      if data[0].sha is $('meta[name=repository_sha]').attr('content')
        notification 'Build is updated', 'green'
        # Check again i 10 minutes
        setTimeout check_update, 10 * 60 * 1000
      else
        # Refresh no cache
        location.reload true

      return # end ajax done

    latest.fail (request, status, error) -> notification "#{status}, #{error}", 'red'

  return # end check_update
{%- capture api -%}
## Update

Every pageload wait 1 minute and compare website build_revision SHA with repository latest commit.  

If they are different reload the page without cache.  

Active only in production `environment = dotcom`.
{%- endcapture -%}