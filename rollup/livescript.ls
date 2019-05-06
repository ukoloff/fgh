require! <[ path livescript rollup-pluginutils ]>

module.exports = live-script


!function live-script(options = {})

  filter = rollup-pluginutils.create-filter options.include, options.exclude
  extensions = new Set options.extensions || <[ .ls ]>

  return {transform, name: \livescript}

  function transform(code, id)
    if filter id and extensions.has path.extname id
      Promise.resolve!then ->
        livescript.compile code, bare: true
      # .then ->
      #   map: ''
      #   code:  it
