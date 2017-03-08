class mymcollective::broker {

  package {
    'activemq':
      ensure  => installed,
      require => [Yumrepo['puppetlabs-products','puppetlabs-dependencies'],File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs']],
  }

  service {
    'activemq':
      ensure  => running,
      enable  => true,
      require => Package['activemq'],
  }

}
