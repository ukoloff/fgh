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
