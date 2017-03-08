class mymcollective::client inherits mymcollective {

  $host = 'fqdn.example.com'

  class {
    '::mcollective':
      client           => true,
      middleware_hosts => [ $host ],
      psk              => 'thisismypsk',
      core_libdir      => '/usr/libexec/mcollective',
      require          => [Yumrepo['puppetlabs-products','puppetlabs-dependencies'],File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs']],
  }

}
