require! <[ ../util/run ]>

module.exports = root
root.scm =
  name: \hg
  log: require \./log

function root
  run args: "hg root"
  .then ->
    it[0]
