class myfirewall::http {

  firewall {
    '200 allow http and https access':
      dport  => [80, 443],
      proto  => tcp,
      action => accept,
  }

}
