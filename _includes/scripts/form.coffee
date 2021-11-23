#
# Initialize serializeJSON
# --------------------------------------
$.serializeJSON.defaultOptions.skipFalsyValuesForTypes = "string,number,boolean,date".split ","

#
# TEMPLATE helper function
# --------------------------------------
get_template = (e, prepend) ->
  if prepend
    template = $ $(e).clone().prop "content"
    # Update labels [for]
    template.find('label[for]').each -> $(@).attr "for", (i, val) -> "#{prepend}[#{val}]"
    # Update inputs [name]
    template.find(':input[name]').attr 'name', (i, val) -> "#{prepend}[#{val}]"
    return template
  else
    return $ $(e).clone().prop "content"

#
# ACTIVATION function
# --------------------------------------
$('form').each ->
  form = $ @

  # Update range output
  form.find("input[type=range]").each ->
    $(@).on "input", (e) -> $(e.target).next("output").val $(e.target).val()
    # Initial update
    $(@).trigger "input"
    return # end Range loop

  # Required asterix
  form.find('input[required]').each ->
    $(@).prev('label').append('*')
    return # end Required loop

  #
  # CREATE SCHEMA
  # --------------------------------------

  # ADD PROPERTY
  form.on 'click', 'a[data-add="property"]', ->

    # Prompt property name
    property_name = prompt 'Property name'

    if property_name
      prepend = "items[properties][#{slugify property_name}]"
      template_property = get_template '#template-property', prepend

      # Update property title
      template_property.find('summary').prepend document.createTextNode "#{property_name} "

      # Get string type
      selected_template = get_template "#template-string", prepend
      template_property.find('[type-inject]').append selected_template

      # Append
      form.find('[properties-inject]').prepend template_property

    return # End add-property

  # REMOVE PROPERTY
  form.on 'click', 'a[data-remove="property"]', -> $(@).parents('.border-top').remove()

  # Change property type
  form.on 'change', 'select[name*="type"]', ->
    # Get parent
    parent = $(@).attr('name').replace "[type]", ''
    selected_template = get_template "#template-#{$(@).val()}", parent
    # Append
    form.find('[type-inject]').empty().append selected_template
    return # End property type change

  #
  # FORM EVENTS
  # --------------------------------------
  # FORM Change
  form.on "change", ':input', (e) ->
    # console.log $(e.target).attr 'name'
    return

  # Reset
  form.on "reset", ->
    # Remove array items and reset index
    # form.find("[array-item]").remove()

    # Reset range output value
    # Default delay is 0ms, "immediately" i.e. next event cycle, actual delay may be longer
    setTimeout -> form.find("input[type=range]").trigger "input"

    # Reset .create-schema forms
    form.find('[properties-inject]').empty()

    return # end Reset

  # Submit
  form.on "submit", ->
    file_content = jsyaml.dump(form.serializeJSON())

    if $('html').hasClass 'logged'
      $(@).find(":input").prop "disabled", true
      url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{form.find('[name="path"]').val()}"
      get_schema = $.get url
      get_schema.fail (request, status, error) ->
        # Schema not found
        if error == 'Not Found'
          load =
            message: "Create schema-array"
            content: btoa file_content
          put = $.ajax url,
            method: 'PUT'
            data: JSON.stringify load
          put.done -> notification 'Created', 'green'
          put.always -> $(@).find(":input").prop "disabled", false
        return
      # File present, overwrite with sha reference
      get_schema.done (data, status) ->
        load =
          message: "Edit schema-array"
          sha: data.sha
          content: btoa file_content
        put = $.put url,
          method: 'PUT'
          data: JSON.stringify load
        put.done -> notification 'Edited', 'green'
        put.always -> $(@).find(":input").prop "disabled", false
        return
    else notification 'You need to login', 'red'

    return # End submit handler

  return # end FORM loop