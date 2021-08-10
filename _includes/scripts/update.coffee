update = ->

  if "{{ site.github.environment }}" is "dotcom"

    # GET repository sha
    latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits'

    latest.done (data) ->
      # Compare online and built repository commit SHA
      if data[0].commit.tree.sha is $('meta[name=repository_sha]').attr('content')
        console.log 'Build is updated', new Date()
      else
        # Refresh no cache
        location.reload true

      # Check every 2 minutes, unauthenticated rate limit is 60 requests per hour.
      setTimeout update, 2 * 60 * 1000

      return # end ajax done

    latest.fail (request, status, error) -> notification "Login #{status}, #{error}", 'red'

  return # end update