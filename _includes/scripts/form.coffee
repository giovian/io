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
  # FORM EVENTS
  # --------------------------------------
  # FORM Change
  form.on "change", ':input', (e) ->
    # console.log $(e.target).attr 'name'
    return

  # Reset
  form.on "reset", ->

    # Reset range output value
    # Default delay is 0ms, "immediately" i.e. next event cycle, actual delay may be longer
    setTimeout -> form.find("input[type=range]").trigger "input"

    return # end Reset handler

  # Submit
  form.on "submit", -> console.log jsyaml.dump form.serializeJSON()

  return # end FORM loop
{%- capture api -%}
## Form

Basic functions of the FORM. Manage reset and submit events, range and required fields.
{%- endcapture -%}