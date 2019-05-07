require! <[ crc32 ]>

# https://sashat.me/2017/01/11/list-of-20-simple-distinct-colors/
distinct-colors = <[
  #e6194B #3cb44b #ffe119 #4363d8 #f58231 #42d4f4
  #f032e6 #fabebe #469990 #e6beff #9A6324 #fffac8
  #800000 #aaffc3 #000075 #a9a9a9 #ffffff #000000
]>

function str2bytes(str)
  result = []
  for , i in str
    c = str.char-code-at i
    do
      result.push c .&. 16~FF
    while c .>>.=8
  result
