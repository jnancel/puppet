class myfirewall::geoip {

  file {
    "/lib/modules/${::kernelrelease}/extra/xt_geoip.ko":
      ensure => present,
      source => "puppet:///modules/myfirewall/lib/modules/${::kernelrelease}/xt_geoip.ko",
      notify => Exec['depmod'];
    '/usr/share/xt_geoip':
      ensure  => directory,
      recurse => true,
      source  => 'puppet:///modules/myfirewall/usr/share/xt_geoip';
    '/usr/lib64/xtables/libxt_geoip.so':
      ensure => present,
      source => "puppet:///modules/myfirewall/usr/lib64/xtables/${::kernelrelease}/libxt_geoip.so",
  }

  exec {
    'depmod':
      command     => "cd /lib/modules/${::kernelrelease}/; depmod",
      refreshonly => true;
    'modprobe xt_geoip':
      command => 'modprobe xt_geoip',
      require => [Exec['depmod'],File["/lib/modules/${::kernelrelease}/extra/xt_geoip.ko", '/usr/share/xt_geoip', '/usr/lib64/xtables/libxt_geoip.so']],
      unless  => 'lsmod | grep -q xt_geoip'
  }

}
