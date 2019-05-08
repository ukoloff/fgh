require! <[ ./m ]>

var repo

title = \fgh
theme = \yeti

module.exports =
  view: ->
    m.fragment do
      m \title get-title!
      m \link do
        rel: \stylesheet
        href: "#{theme}/bootstrap.min.css"

  set-root: set-root

function get-title
  if repo
    "#{title.replace repo.mode[0], repo.mode[0].toUpperCase!}: #{repo.name} @ #{repo.base}"
  else
    title

!function set-root(root, flavour = \git)
  if /^(?:(.*)[\\\/]+)?(.+)$/.exec root
    repo :=
      path: root
      name: that[2]
      base: that[1]
      mode: flavour
    m.redraw!
