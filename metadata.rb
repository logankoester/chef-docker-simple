name 'docker-simple'
maintainer 'Logan Koester'
maintainer_email 'logan@logankoester.com'
license 'MIT License'
description 'Installs/Configures Docker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.3'

depends 'pacman'
depends 'ssl_certificate'

supports 'arch'
