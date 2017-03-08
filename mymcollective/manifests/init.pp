class mymcollective {

  if $::osfamily == 'RedHat' {
    yumrepo {
      'puppetlabs-products':
        descr    => 'puppetlabs-products',
        ensure   => present,
        baseurl  => 'http://yum.puppetlabs.com/el/7/products/$basearch',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        enabled  => 1,
        gpgcheck => 1;
      'puppetlabs-dependencies':
        descr    => 'puppetlabs-dependencies',
        ensure   => present,
        baseurl  => 'http://yum.puppetlabs.com/el/7/dependencies/$basearch',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        enabled  => 1,
        gpgcheck => 1;
    }

    file {
      '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
        ensure => present,
        source => 'puppet:///modules/mymcollective/RPM-GPG-KEY-puppetlabs',
    }

  }

}
