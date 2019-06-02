require! <[ ../util/run ]>

module.exports = root
root.scm =
  name: \fossil
  log: require \./log

function root
  run args: "fossil info"
  .then extract-root

function extract-root(lines)
  (lines.filter -> /^\S*\broot:/i.test it
  .[0] or '').split /\s+/ 2
  .[1]
