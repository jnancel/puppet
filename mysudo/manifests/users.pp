define mysudo::users($impersonate) {

  augeas {
    "sudoers configuration ${name}":
      context => '/files/etc/sudoers',
      changes => [
        "set spec[user = '${name}']/user ${name}",
        "set spec[user = '${name}']/host_group/host ALL",
        "set spec[user = '${name}']/host_group/command ALL",
        "set spec[user = '${name}']/host_group/command/runas_user ${impersonate}",
      ];
  }
}
