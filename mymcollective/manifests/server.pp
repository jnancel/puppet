class mymcollective::server inherits mymcollective {

  if $::osfamily == 'RedHat' {
    $require = [Yumrepo['puppetlabs-products','puppetlabs-dependencies'],File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs']]
    $classes = '/var/lib/puppet/classes.txt'
  } elsif $::osfamily == 'Debian' {
    $classes = '/var/lib/puppet/state/classes.txt'
    if $::lsbdistcodename == 'wheezy' {
      $require = Exec['apt_update']

      exec {
        'Get facts':
          command => 'facter -y > /etc/mcollective/facts.yaml',
          require => Class['::mcollective'],
      }
    } elsif $::osfamily == 'jessie' {

    }
  }

  $host = 'fqdn.example.com'

  class {
    '::mcollective':
      middleware_hosts => [ $host ],
      core_libdir      => '/usr/libexec/mcollective',
      psk              => 'thisismypsk',
      classesfile      => $classes,
      require          => $require,
  }

  package {
    [
      'mcollective-service-agent',
      'mcollective-puppet-agent',
    ]:
      ensure  => installed,
      require => $require,
  }

}
