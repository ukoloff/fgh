var j = require('JSONStream')
var es = require('event-stream')

var hg = require('./hg')

hg()
.pipe(j.parse('*'))
// .pipe(es.mapSync(JSON.stringify))
// .pipe(es.mapSync(console.log))
