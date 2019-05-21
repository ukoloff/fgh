var { spawn } = require('child_process')
var { join } = require('path')

module.exports = run

function run() {
  return spawn('hg',
    ['log', '-T', 'json', '-l', '1234567890'],
    { cwd: join(__dirname, '../tmp/system50001')})
    .stdout
}
