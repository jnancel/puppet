class myhaproxy {

  class {
    'haproxy':
      global_options   => {
        log                         => '127.0.0.1 local2',
        'tune.ssl.default-dh-param' => 2048,
        'stats'                     => [
          'socket /var/run/haproxy.sock mode 666 level user',
          'timeout 2m',
        ],
        'ssl-default-bind-options'  =>  'no-sslv3 no-tls-tickets',
        'ssl-default-bind-ciphers'  =>  'DHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA'
      },
      defaults_options => {
        'log'     => 'global',
        'maxconn' => 8000,
        'option'  => [
          'redispatch',
          'forwardfor',
        ],
        'retries' => 3,
        'timeout' => [
          'http-request 10s',
          'queue 1m',
          'connect 10s',
          'client 1m',
          'server 1m',
          'check 10s',
        ],
        'stats'   => [
          'enable',
          'uri /stats',
          'realm HAProxy Statistics',
          'auth root:veritas-123@',
        ],
      },
  }

  file {
    '/var/lib/ssl':
      ensure  => directory,
      recurse => true,
      source  => "puppet:///modules/myhaproxy/ssl_certs/${::hostname}",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
  }

  $mybackend = hiera_hash('myhaproxy::backend', {})
  create_resources('myhaproxy::backend', $mybackend)

  $myfrontend = hiera_hash('myhaproxy::frontend', {})
  create_resources('myhaproxy::frontend', $myfrontend)

  $mybalancer = hiera_hash('myhaproxy::balancer', {})
  create_resources('myhaproxy::balancer', $mybalancer)

}
