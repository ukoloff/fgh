require! <[ octicons ]>
m = require \mithril

module.exports =
  view: ->
    m.trust octicons[it.attrs.id].toSVG! + ' '
