require! <[ octicons ./m ]>

module.exports =
  onbeforeupdate: ->
    false
  view: ->
    m.trust octicons[it.attrs.id].toSVG! + ' '
