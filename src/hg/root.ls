require! <[ ../util/run ]>

module.exports = root
root.scm = 'hg'

function root
  run args: "hg root"
  .then ->
    it[0]
