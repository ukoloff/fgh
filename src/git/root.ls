require! <[ ../util/run ]>

module.exports = root

function root
  run args: "git rev-parse --show-toplevel"
  .then do
    -> console.log \ROOT it
    -> console.log \ERROR it
