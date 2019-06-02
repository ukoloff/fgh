require! <[ ./util/root ./view/head ]>

set-timeout !->
  head!
  winner <-! root!.then
  winner.scm.log!
