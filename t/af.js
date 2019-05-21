var j = require('JSONStream')
var es = require('event-stream')

var fo = require('./fo')

fo()
.pipe(j.parse('payload.timeline.*'))
// .pipe(es.mapSync(JSON.stringify))
// .pipe(es.mapSync(console.log))
