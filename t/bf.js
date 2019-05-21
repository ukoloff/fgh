var j = require('oboe')
var es = require('event-stream')

var fo = require('./fo')

j(fo())
  .node('!.payload.timeline.*', node)

function node(node) {
  // console.log(JSON.stringify(node))
  return j.drop
}
