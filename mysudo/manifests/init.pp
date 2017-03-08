class mysudo {

  $users = hiera_hash('mysudo::users', {})
  create_resources('mysudo::users', $users)
}


