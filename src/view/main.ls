require! <[ ./m ]>

module.exports <<< {
  append
}

var history
var render-start
visible-length = 0

!function append(commits)
  unless history
    history := []
    m.mount document.body, log-view

  history.push ...commits
  console.log \= history.length
  unless render-start
    show-more!

!function show-more
  if visible-length < history.length
    render-start := +new Date
    visible-length += Math.min 100 history.length - visible-length

    m.redraw!
  else
    render-start := void

!function render-end
  set-timeout show-more, pause = +new Date - render-start
  console.log pause, visible-length

log-view =
  view: ->
    m \.container-fluid m \table.table.table-striped.table-hover m \tbody history.map (commit)->
      m do
        \tr
        key: commit.id
        m do
          \label.form-check.form-check-label
          m \input.form-check-input do
            type: \radio
            name: \id
            value: \commit.id

          commit.comment
          m \br
          m do
            \small
            # m \br
            m \span.text-info format-date commit.date
            ' '
            m \span.text-success commit.user
  onupdate: render-end

function format-date(date)
  "#{
    date.to-time-string!split /\s+/ .0} #{
    date.get-full-year!}-#{
    f02 date.get-month! + 1}-#{
    f02 date.get-date!}"

function f02(num)
  num = "#{num}"
  while num.length < 2
    num = "0#{num}"
  num
