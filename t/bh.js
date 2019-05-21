var j = require('oboe')
var es = require('event-stream')

var hg = require('./hg')

j(hg())
  .node('!.*', node)

function node(node) {
  // console.log(JSON.stringify(node))
}
