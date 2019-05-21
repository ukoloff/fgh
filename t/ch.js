// var {parser} = require('stream-json')
var StreamArray = require('stream-json/streamers/StreamArray')
// var StreamValues = require('stream-json/streamers/StreamValues')
var es = require('event-stream')

var hg = require('./hg')

hg()
  .pipe(StreamArray.withParser())
  // .pipe(StreamValues.withParser())
  .pipe(es.mapSync(_ => { }))
  // .pipe(es.mapSync(JSON.stringify))
  // .pipe(es.mapSync(console.log))
