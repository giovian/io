$('form.document').each ->
  form = $ @

  load_schema = ->
    schema_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{form.attr 'data-schema'}.schema.json"
    form.attr 'disabled', ''
    get_schema = $.get schema_url
    get_schema.done (data, status) ->
      # Get schema: decode from base 64 and parse as yaml
      schema = JSON.parse Base64.decode(data.content) # jsyaml.load
      if schema.type isnt 'array'
        notification "schema type `#{schema.type}` to do", 'red', true
      # Loop items properties
      for own key, value of schema.items.properties
        # Default variabiles
        field = $ '<input/>', {type: 'text'}
        data_type = 'string'

        # Check property type and format
        switch value.type
          when 'string'
            switch value.format
              when 'textarea'
                field = $ '<textarea/>', {'data-skip-falsy': true, spellcheck: false}
                data_type = 'textarea'
              when 'date' then field.attr 'type','date'
              when 'uri' then field.attr 'type', 'url'
              when 'date-time' then field.attr 'type', 'datetime-local'
              when 'email', 'color', 'time' then field.attr 'type', value.format
          when 'number', 'integer'
            data_type = 'number'
            field.attr 'type', 'number'
            field.attr 'data-value-type', 'number'
            if value.format is 'range'
              data_type = 'range'
              field.attr 'type', 'range'
          when 'boolean'
            data_type = 'select'
            field = $('<select/>',
              class: 'inline mhh'
              'data-value-type': 'boolean'
            ).append [
              $ '<option/>', {value: true, text: 'True'}
              $ '<option/>', {value: false, text: 'False'}
            ]
          else notification "Property type `#{value.type}` to do", 'red', true

        # Complete field attributes
        field.attr 'name', key
        # String
        if value.maxLength then field.attr 'maxlength', value.maxLength
        if value.minLength then field.attr 'minlength', value.minLength
        if value.pattern then field.attr 'pattern', value.pattern
        # Number
        if value.minimum then field.attr 'min', value.minimum
        if value.maximum then field.attr 'max', value.maximum
        # Prepare elements
        label = $ '<label/>', {text: value.title || key, for: key}
        div = $ '<div/>', {'data-type': data_type}
        # Integer
        if value.type is 'integer' then field.attr 'step', 1
        div.append [label, field]
        if value.format is 'range'
          div.append $('<output/>', {for: key})
          range_enable field
        if value.description then div.append $('<span/>': {text: value.description})
        # Append DIV to FORM
        form.find('[inject]').append div
      # End properties loop
      return # End schema request
    get_schema.always -> form.removeAttr 'disabled'
    return # End load_schema function

  # Populate form
  if form.attr 'data-schema' then load_schema()

  # Reset
  form.on 'reset', ->
    # Reset .create-schema forms
    form.find('[inject]').empty()
    # Load schema
    if form.attr 'data-schema' then load_schema()
    return # end Reset handler

  # Submit
  form.on 'submit', ->
    load = form.serialize()
    head = load.split('&').map((e) -> e.split('=')[0]).join ','
    line = load.split('&').map((e) -> e.split('=')[1]).join ','
    console.log load, head, line
    # file don't exist
      # create file head and line
    # file exist
      # append line
    return # End SUBMIT

  return # End form loop