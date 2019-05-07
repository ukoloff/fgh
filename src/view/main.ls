require! <[ ./octicon ]>
m = require \mithril

module.exports = main-view

function main-view(list)
  view: ->
    m \.container-fluid list.map ->
      m \.,
        m octicon, do
          id: if it.up.length > 1 then \git-merge else \git-commit
        it.subj
