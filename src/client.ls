require! <[ ./util/root ./view/head ./view/error ]>

set-timeout !->
  head!
  winner <-! root!.then
  if winner
    winner.scm.log!
  else
    error "No repo found!"
