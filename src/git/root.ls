require! <[ ../util/run ]>

module.exports = root
root.scm = 'git'

function root
  run args: "git rev-parse --show-toplevel"
  .then ->
    it[0]