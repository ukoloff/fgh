var { spawn } = require('child_process')
var { join } = require('path')

module.exports = run

function run() {
  return spawn('fossil',
    ['json', 'timeline', 'checkin', '-n', 0],
    { cwd: join(__dirname, '../tmp/fssl')})
    .stdout
}
