require! <[ ./m ]>

theme = \yeti

module.exports =
  view: ->
    m.fragment do
      m \title \fgh
      m \link do
        rel: \stylesheet
        href: "#{theme}/bootstrap.min.css"
