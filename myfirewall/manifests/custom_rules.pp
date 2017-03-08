define myfirewall::custom_rules (
  $id,
  $chain = 'INPUT',
  $proto = 'tcp',
  $action = undef,
  $sport = undef,
  $dport = undef,
  $source = undef,
  $destination = undef,
  $jump = undef,
  $table = undef,
  $toports = undef,
  $todest = undef,
  $tosource = undef,
  $outiface = undef,
  $iniface = undef
) {

  firewall {
    "${id} : ${name}":
      chain       => $chain,
      source      => $source,
      sport       => $sport,
      destination => $destination,
      dport       => $dport,
      proto       => $proto,
      action      => $action,
      jump        => $jump,
      table       => $table,
      toports     => $toports,
      todest      => $todest,
      tosource    => $tosource,
      outiface    => $outiface,
      iniface     => $iniface,
  }

}
