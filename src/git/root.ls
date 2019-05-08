require! <[ ../util/run ../view/head ]>

module.exports = root

function root
  run args: "git rev-parse --show-toplevel"
  .then do
    ->
      head.set-root it[0]
    ->
      console.log \ERROR it
