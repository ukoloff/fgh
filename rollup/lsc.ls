require! <[ child_process ]>

child_process.spawn \lsc <[ -cbo server src/server ]> do
  stdio: \inherit
  shell: true
