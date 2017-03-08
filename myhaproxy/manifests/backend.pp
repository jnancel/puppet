define myhaproxy::backend (
  $back,
  $mode = 'http',
  $persistent = undef,
  $redirect = undef,
  $redispw = undef,
  $opts = ['tcplog'],
) {

  if $persistent != undef {
    $cookie_value = 'SERVERID insert'
  } else {
    $cookie_value = undef
  }

  if $redispw != undef {
    $tcp_check = [
      "send AUTH\ ${redispw}\\r\\n",
      'send PING\r\n',
      'expect string +PONG',
      'send info\ replication\r\n',
      'expect string role:master',
      'send QUIT\r\n',
      'expect string +OK'
    ]
  } else {
    $tcp_check = undef
  }

  $options = delete_undef_values({
    'option'  => $opts,
    'balance' => 'roundrobin',
    'cookie'  => $cookie_value,
    'redirect' => $redirect,
    'tcp-check' => $tcp_check,
  })

  haproxy::backend {
    $name:
      options => $options,
      mode    => $mode,
  }

}
