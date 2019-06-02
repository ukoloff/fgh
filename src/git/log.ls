require! <[ ../util/channel ../view/main ../view/error ]>

module.exports = git-log

fields = parseFields do
  id:     H: id = -> it
  parents:     'P .': -> it.split /\s+/ .slice 0 -1
  comment:   s: id
  user: 'an <%ae>': id
  date:   aI: -> new Date it

function parse-fields(rec)
  for k, v of rec
    for key, format of v
      break
    name: k
    key: key
    format: format

function git-log
  channel do
    cmd: \run
    args: <[ git log --all ]>.concat "--format=#{fields.map(-> "%#{it.key}%n").join ''}"
    ondata: chunk
    onerror: error

pending = []

!function chunk(msg)
  git-log = []

  for line in msg.out
    line .= trim!
    unless line
      if pending.length == fields.length
        commit = {}
        for z, j in fields
          commit[z.name] = pending[j]
        git-log.push commit
      pending.length = 0
    else if pending.length <= fields.length
      pending.push if pending.length < fields.length
        fields[pending.length].format line

  main.append git-log
