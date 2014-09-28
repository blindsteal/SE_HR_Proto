Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin', '/usr/local/bin']
}

# --- Preinstall Stage ---#

stage { 'preinstall':
  before => Stage['main']
}

# Define the install_packages class
class install_packages {
  package { [
    'curl',
    'build-essential',
    'libfontconfig1',
    'python',
    'g++',
    'make',
    'wget',
    'tar',
    'mc',
    'htop']:
    ensure => present
  }
}

# Declare (invoke) install_packages
class { 'install_packages':
  stage => preinstall
}
	
# --- MongoDB --- #

class {'::mongodb::server':
  verbose => true
}

# --- NodeJS --- #

class { 'nodejs':
  version => 'v0.10.32',
  make_install => false
}

package { 'bower':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

package { 'grunt-cli':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

package { 'yo':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

package { 'generator-angular-fullstack':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

package { 'express':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

package { 'mongoose':
  ensure   => present,
  provider => 'npm',
  require => Class['nodejs']
}

# --- Heroku Toolbelt --- #

exec { "getheroku" :
    command => "wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh -o /tmp/install-ubuntu.sh | sh",
    path => "/usr/local/bin:/bin:/usr/bin",
    creates => "/tmp/install-ubuntu.sh",
	require => Class['install_packages']
}