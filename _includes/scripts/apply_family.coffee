# apply-if-parent apply-if-children attributes in the form "class|target_selector"
apply_family = () ->
  $('[apply-if-parent]').each ->
    [apply, match] = $(@).attr('apply-if-parent').split '|'
    $(@).removeClass apply
    if $(@).parents(match).length then $(@).addClass apply
    return
  $('[apply-if-children]').each ->
    [apply, match] = $(@).attr('apply-if-children').split '|'
    $(@).removeClass apply
    if $(@).find(match).length then $(@).addClass apply
    return
  true

apply_family()