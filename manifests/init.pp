class amitools (
  $installdir = '/opt/amitools',
  $targetdir = '/usr/local/bin',
) {
  file { $installdir:
    ensure => directory,
  }

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  }

  if ! defined(Package['unzip']) {
    package { 'unzip':
      ensure => installed,
    }
  }

  if ! defined(Package['wget']) {
    package { 'wget':
      ensure => installed,
    }
  }

  if ! defined(Package['kpartx']) {
    package { 'kpartx':
      ensure => installed,
    }
  }

  if ! defined(Package['kpartx']) {
    package { 'kpartx':
      ensure => installed,
    }
  }

  if ! defined(Package['gdisk']) {
    package { 'gdisk':
      ensure => installed,
    }
  }

  $amitools = '/tmp/ec2-ami-tools.zip'
  exec { 'download-amitools':
    command => "wget -O ${amitools} http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.zip",
    cwd     => '/tmp',
    creates => $amitools,
    user    => 'root',
  }

  exec { 'install-amitools':
    command => "unzip -q ${amitools} && ln -s `/bin/ls -1trd ec2-ami-tools-[0-9]* | tail -1` current",
    cwd     => $installdir,
    creates => "${installdir}/current/license.txt",
    user    => 'root',
    require => [
      Package['unzip'],
      Package['wget'],
      File[$installdir],
      Exec['download-amitools'],
    ],
  }

  $bindir = "${installdir}/current/bin"
  exec { 'update-amitools-links':
    command => "bash -c 'for bin in * ; do ln -sf ${bindir}/\$bin ${targetdir}/\$bin ; done'",
    cwd     => $bindir,
    creates => "${targetdir}/ec2-ami-tools-version",
    user    => 'root',
    require => [
      Exec['install-amitools'],
    ],
  }
}
