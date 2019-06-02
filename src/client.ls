require! <[ ./util/root ./view/head ]>

set-timeout !->
  head!
  <-! root!.then
  do require \./git/log
