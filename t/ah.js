var j = require('JSONStream')
// var es = require('event-stream')

var hg = require('./hg')

hg()
.pipe(j.parse('*'))
.on('data', dumper)
// .pipe(es.mapSync(JSON.stringify))
// .pipe(es.mapSync(console.log))

function dumper(data) {
  console.log(':', JSON.stringify(data))
}
