module.exports = root

detectors =
  require \../fossil/root
  require \../hg/root
  require \../git/root

function root
  Promise.all detectors.map build
  .then ->
    it
    .filter id
    .reduce longest
  .then inform
  .catch noop

function build(detector)
  detector!then ->
    scm: detector.scm
    root: it
  .catch noop

function noop
  void

function id
  it

function longest(a, b)
  if a.root.length >= b.root.length
    a
  else
    b

function inform(rec)
  if /^(?:(.*)[\\\/]+)?(.+)$/.exec rec.root
    document.title = "#{
      document.title.replace rec.scm.name[0], rec.scm.name[0].toUpperCase!}: #{
      rec.name = that[2]} @ #{
      rec.base = that[1]}"
  rec
