require! <[ ./m ]>

module.exports <<< {
  append
}

var history

!function append(commits)
  unless history
    history := []
    m.mount document.body, log-view

  history.push ...commits
  m.redraw!

log-view =
  view: ->
    m \.container-fluid history.map (commit)->
      m do
        \.commit
        key: commit.id
        commit.subj
        m do
          \small
          m \br
          m \span.text-info format-date commit.date
          ' '
          m \span.text-success commit.author

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
