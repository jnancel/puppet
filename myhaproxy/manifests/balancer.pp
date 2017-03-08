define myhaproxy::balancer ( $backend, $ip, $ports = 80, $check = 'check', $cookies = undef ) {

  haproxy::balancermember {
    $name:
      listening_service => $backend,
      server_names      => $name,
      ipaddresses       => $ip,
      ports             => $ports,
      options           => $check,
      define_cookies    => $cookies,
  }

}
