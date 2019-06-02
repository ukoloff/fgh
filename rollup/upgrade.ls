# Upgrade rollup plugin to use writeBundle hook

module.exports = upgrade-plugin

function upgrade-plugin(plugin)
  if 'function' != typeof plugin.write-bundle
    for k, v of plugin when /^on/.test k and 'function' == typeof v
      delete plugin[k]
      plugin.write-bundle = create-write-bundle v
      break
  plugin

function create-write-bundle(old)
  function write-bundle(details)
    for , v of details when 'object' == typeof v and v.code
      details.bundle = v
      break
    old ...
