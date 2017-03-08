class myfirewall {

  class {
    ['myfirewall::pre', 'myfirewall::post', 'firewall']:
  }

  Firewall {
    before => Class['myfirewall::post'],
    require => Class['myfirewall::pre'],
  }

  $home = 'xx.xx.xx.xx'
  $netpriv = '172.16.0.0/16'

  firewall {
    '004 allow all from netpriv':
      action => accept,
      proto  => 'all',
      source => $netpriv;
  }

  firewall {
    '010 allow ssh access from home':
      dport  => 22,
      proto  => tcp,
      action => accept,
      source => $home;
  }

  $customrules = hiera_hash('myfirewall::custom_rules', {})
  create_resources('myfirewall::custom_rules', $customrules)

}


