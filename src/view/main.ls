# require! <[ ./octicon ]>
require! <[ ./m ]>

module.exports = main-view

function main-view(list)
  view: ->
    m \.container-fluid list.map ->
      m \.,
        key: it.id
        # m octicon, do
        #   id: if it.up.length > 1 then \git-merge else \git-commit
        it.subj
        m \small,
          m \br
          m \span.text-info format-date it.date
          ' '
          m \span.text-success it.author

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
