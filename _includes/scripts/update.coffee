update = (timer = 60 * 1000) ->

  # GET latest build
  latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds/latest'

  latest.done (data) ->
    # Compare online and built repository commit SHA
    if data.commit is $('meta[name=repository_sha]').attr('content')
      notification 'build is updated'
    else
      # Check if new website is built
      if data.status is 'built'
        # Refresh no cache
        location.reload true
      else if data.status in ['building', 'queued']
        # Website is building, check frequently
        notification "#{data.status}: timer one second"
        timer = 1000

    setTimeout update, timer
    return # end ajax done

  return # end update

update()