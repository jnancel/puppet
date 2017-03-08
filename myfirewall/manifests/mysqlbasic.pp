class myfirewall::mysqlbasic {

  $home = 'xx.xx.xx.xx'

  firewall {
    '300 allow MySQL access from home':
      dport  => 3306,
      proto  => tcp,
      action => accept,
      source => $home,
  }

}
