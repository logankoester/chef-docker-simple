include_recipe 'pacman'

%w{
  python2-texttable
  python2-websocket-client-pebble
  python2-docker-py
  python2-dockerpty
  docker-compose
}.each do |pkg|
  pacman_aur(pkg){ action [:build, :install] }
end
