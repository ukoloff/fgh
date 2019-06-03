require! <[ fs path ]>

for file in fs.readdir-sync folder = path.join __dirname, \../../client
  when /[.]map$/ == file
    fs.unlink-sync path.join folder, file
