require! <[ ./m ]>

theme = \yeti

module.exports = ->
  m.mount document.head, head-view

head-view =
  view: ->
    m.fragment do
      m \title \fgh
      m \link do
        rel: \stylesheet
        href: "#{theme}/bootstrap.min.css"
      m \link do
        rel: \stylesheet
        href: \css/font-awesome.min.css
