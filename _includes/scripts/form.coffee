#
# Initialize serializeJSON
# --------------------------------------
$.serializeJSON.defaultOptions.skipFalsyValuesForTypes = "string,number,boolean,date".split ","

#
# ACTIVATION function
# --------------------------------------
activate_form = (element) ->
  form = $ element

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
  if form.hasClass 'create-schema'
    # Insert type schema
    form.find('[schema-inject]').append get_template('#template-type')
    # Bind onChange event to Schema type
    form.on 'change', '[name=type]', ->
      form.find('[type-inject]').empty().append get_template "#template-#{$(@).val()}"
      # First call append items-type
      if form.find("[name='items[type]']").length
        item_type = nest(get_template("#template-#{form.find("[name='items[type]']").val()}"), 'items')
        form.find('[items-type-inject]').empty().append item_type
      return
    # Bind onChange event to array Items type
    form.on 'change', "[name='items[type]']", ->
      item_type = nest(get_template("#template-#{$(@).val()}"), 'items')
      form.find('[items-type-inject]').empty().append item_type
      return
    # First call append type
    form.find('[type-inject]').empty().append get_template "#template-#{form.find('[name=type]').val()}"

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
    # setTimeout -> form.find("input[type=range]").trigger "input"
    form.find('[type-inject]').empty().append get_template "#template-string"
    return # end Reset

  # Submit
  form.on "submit", -> console.dir form.serializeJSON()

  return # end FORM loop

#
# NEST
# --------------------------------------
nest = (element, father) ->
  element.find(':input').attr 'name', (i, val) -> "#{father}[#{val}]"
  # element.find('[show-if-value]').attr 'show-if-value', (i, val) ->
  #   [selector, value] = val.split '|'
  #   selector_array = selector.split("=")
  #   return "#{selector_array[0]}='items[#{selector_array[1]}']|#{value}"
  return element

#
# TEMPLATE helper function
# --------------------------------------
get_template = (e) -> $ $(e).clone().prop "content"

#
# STARTUP
# --------------------------------------
# Activate every FORM
$('form').each -> activate_form @