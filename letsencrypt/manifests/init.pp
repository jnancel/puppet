class letsencrypt {

  if $::osfamily == 'Debian' {
    file {
      '/etc/apt/sources.list.d/backports.list':
        ensure  => present,
        content => template('letsencrypt/backports.list.erb'),
    }
    $require = [File['/etc/apt/sources.list.d/backports.list'], Exec['apt_update']]
    $install_options = [ '-t', "${lsbdistcodename}-backports"]
  } elsif $::osfamily == 'RedHat' {
    cron {
      'Certbot certificate renewal':
        command => 'certbot renew --quiet',
        user    => 'root',
        hour    => 3,
        minute  => 0,
    }
    $require = undef
    $install_options = undef
  }

  package {
    'python-certbot-apache':
      ensure          => installed,
      require         => $require,
      install_options => $install_options,
  }

}
