module.exports = oops

function oops(wskt, args)
  Promise.reject Error "Inknown command: #{args?.cmd ? \?}"
