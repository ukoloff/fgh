require! <[ ./m ]>

module.exports = error

function error(exception)
  m.mount do
    document.body
    view: ->
      m.fragment do
        m \. "#{exception}"
