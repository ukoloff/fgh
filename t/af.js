var j = require('JSONStream')
// var es = require('event-stream')

var fo = require('./fo')

fo()
.pipe(j.parse('payload.timeline.*'))
.on('data', dumper)
// .pipe(es.mapSync(JSON.stringify))
// .pipe(es.mapSync(console.log))

function dumper(data) {
  console.log(':', JSON.stringify(data))
}
