require! <[ octicons ]>
m = require \mithril

module.exports =
  onbeforeupdate: ->
    false
  view: ->
    m.trust octicons[it.attrs.id].toSVG! + ' '
