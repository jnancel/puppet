define myhaproxy::frontend ( $bind, $redirect = undef, $reqirep = undef, $mapregex = undef, $acl = undef, $block = undef, $mode = 'http', $backend = undef ) {

  if $mapregex == undef {
    $mymap = 'map'
  } else {
    $mymap = 'map_reg'
  }

  if $mode == 'http' {
    $httpresponse = [
      'set-header Strict-Transport-Security max-age=31536000;\ includeSubdomains;\ preload',
      'set-header X-Frame-Options DENY',
      'set-header X-Content-Type-Options nosniff',
    ]

    $rspadd = [
      'X-XSS-Protection:\ 1;\ mode=block',
      'Content-Security-Policy:\ upgrade-insecure-requests',
    ]
  } else {
    $httpresponse = undef
    $rspadd = undef
  }

  if $redirect != undef {
    $final_redirect = $redirect
  }

  if $reqirep != undef {
    $final_reqirep = $reqirep
  }

  if $acl != undef {
    $final_acl = $acl
  }

  if $block != undef {
    $final_block = $block
  }

  if $mode == 'http' {

    $mapping = hiera("myhaproxy::mapfile.${name}")
    haproxy::mapfile {
      $name:
        ensure   => present,
        mappings => [
          $mapping,
        ],
    }

    $use_backend = "%[req.hdr(host),lower,${mymap}(/etc/haproxy/${name}.map,my_default)]"
    $require = [Haproxy::Mapfile[$name],File['/var/lib/ssl']]
  } elsif $mode == 'tcp' {
    $use_backend = $backend
    $require = undef
  }

  $options = delete_undef_values({
    'use_backend'   => $use_backend,
    'http-response' => $httpresponse,
    'rspadd'        => $rspadd,
    'redirect'      => $final_redirect,
    'reqirep'       => $final_reqirep,
    'acl'           => $final_acl,
    'block'         => $final_block,
  })

  haproxy::frontend {
    $name:
      mode    => $mode,
      options => $options,
      bind    => $bind,
      require => $require,
  }

}
