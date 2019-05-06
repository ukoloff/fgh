module.exports = parseFields do
  id:     H: id
  up:     P: split
  subj:   s: id
  aname:  an: id
  amail:  ae: id
  adate:  aI: date
  cname:  cn: id
  cmail:  ce: id
  cdate:  cI: date

function id
  it

function split
  it.split /\s+/

function date it
  new Date it

function parse-fields(rec)
  for k, v of rec
    for key, format of v
      break
    name: k
    key: key
    format: format
