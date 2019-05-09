module.exports = root
detectors =
  require \../fossil/root
  require \../hg/root
  require \../git/root

function root
  Promise.all detectors.map ->
    it!catch ->
  .then ->
    console.log \ROOTS it
