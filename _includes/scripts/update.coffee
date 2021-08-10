update = (timer = 60 * 1000) ->

  # GET latest build
  latest = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds/latest'

  latest.done (data) ->
    # Compare online and built repository commit SHA
    if data.commit is $('meta[name=repository_sha]').attr('content')
      console.log "build is updated"
    else
      # Check if new website is built
      if data.status is 'built'
        # Refresh no cache
        location.reload true
        setTimeout update, timer
      else if data.status in ['building', 'queued']
        # Website is building, check frequently
        console.log ['building', 'queued'], 'timer one second'
        setTimeout update, 1000
    return # end ajax done

  return # end update

update()