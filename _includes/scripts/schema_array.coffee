#
# Initialize serializeJSON
# --------------------------------------
$.serializeJSON.defaultOptions.skipFalsyValuesForTypes = 'string,number,boolean,date'.split ','

#
# TEMPLATE helper function
# --------------------------------------
get_template = (e, prepend) ->
  if prepend
    template = $ $(e).clone().prop 'content'
    # Update labels [for]
    template.find('label[for]').each -> $(@).attr 'for', (i, val) -> "#{prepend}[#{val}]"
    # Update inputs [name]
    template.find(':input[name]').attr 'name', (i, val) -> "#{prepend}[#{val}]"
    return template
  else
    return $ $(e).clone().prop 'content'

#
# PROPERTY inject helper function
# --------------------------------------
get_property = (key, value) ->
  prepend = "items[properties][#{slug key}]"
  template_property = get_template '#template-property', prepend
  # Update property title
  template_property.find('summary').prepend document.createTextNode "#{key} "
  # Get property type
  property_type = value?.type || 'string'
  selected_template = get_template "#template-#{property_type}", prepend
  # Set property values
  for own key, property of value
    selected_template.find("[name$='[#{key}]']").val property
  # Append property
  template_property.find('[type-inject]').append selected_template
  return template_property # End property inject

#
# ACTIVATION function
# --------------------------------------
$('form.schema-array').each ->
  form = $ @

  load_schema = ->
    schema_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{form.attr 'data-schema'}.schema.json"
    notification 'Reading schema file'
    get_schema = $.get schema_url
    get_schema.done (data, status) ->
      notification 'Schema acquired', 'green'
      # Get schema: decode from base 64 and parse as yaml
      schema = jsyaml.load Base64.decode data.content
      # Populate fields
      form.find('[name="title"]').val schema.title
      form.find('[name="$id"]').val schema['$id']
      form.find('[name="description"]').val schema.description
      for own key, value of schema.items.properties
        form.find('[properties-inject]').prepend get_property(key, value)
      return # Form is populated
    get_schema.fail -> form.find('[name="$id"]').val form.attr('data-schema')
    return # End load_schema function

  # Populate form
  if form.attr 'data-schema' then load_schema()

  #
  # CREATE SCHEMA
  # --------------------------------------

  # ADD PROPERTY
  form.on 'click', 'a[data-add="property"]', ->
    # Prompt property name
    property_name = prompt 'Property name'
    # Inject property
    if property_name
      form.find('[properties-inject]').prepend get_property(property_name)
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
  form.on 'change', ':input', (e) ->
    # console.log $(e.target).attr 'name'
    return

  # Reset
  form.on 'reset', ->
    # Load schema
    if form.attr 'data-schema' then load_schema()

    # Reset .create-schema forms
    form.find('[properties-inject]').empty()

    return # end Reset handler

  # Submit
  form.on 'submit', ->

    # Check user is logged
    if $('html').hasClass 'logged'
      # Prepare variabiles
      encoded_file_content = Base64.encode form.serializeJSON()
      url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{form.find('[name="$id"]').val()}.schema.json"
      notification 'Check if file exist'
      # Check if file already exist
      get_schema = $.get url
      get_schema.fail (request, status, error) ->
        # Schema not found
        if error == 'Not Found'
          load =
            message: "Create schema-array"
            content: encoded_file_content
          # Commit new file
          notification load.message
          put = $.ajax url,
            method: 'PUT'
            data: JSON.stringify load
          put.done (data, status)->
            storage.assign 'repository', {sha: data.commit.sha}
            notification 'Schema created', 'green'
            return # End commit
        return # End new file
      # File present, overwrite with sha reference
      get_schema.done (data, status) ->
        load =
          message: 'Edit schema-array'
          sha: data.sha
          content: encoded_file_content
        # Commit edited file
        notification 'load.message'
        put = $.ajax url,
          method: 'PUT'
          data: JSON.stringify load
        put.done (data, status) ->
          storage.assign 'repository', {sha: data.commit.sha}
          notification 'Schema edited', 'green'
        return # End overwrite
    else notification 'You need to login', 'red'

    return # End submit handler

  return # end FORM loop
{%- capture api -%}
## Schema array

Manage a schema of `type=array`.

```liquid
{% raw %}{% include schema-array.html %}{% endraw %}
```

**Includes**

- `schema`: URI-reference of the schema to load (no extension)
{%- endcapture -%}