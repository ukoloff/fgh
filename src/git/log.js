var logFields = {
  id: { H: id },
  up: { P: split },
  subj: { s: id },
  aname: { an: id },
  amail: { ae: id },
  adate: { aI: date },
  cname: { cn: id },
  cmail: { ce: id },
  cdate: { cI: date },
}

var logArgs = parseFields(logFields)

export default logArgs

function id(it) {
  return it
}

function split(it) {
  return it.split(/\s+/)
}

function date(it) {
  return new Date(it)
}

function parseFields(f) {
  var result = []
  for (var k in f) {
    var v = f[k]
    var z
    for (z in v) break
    result.push({ name: k, key: z, format: v[z] })
  }
  return result
}
