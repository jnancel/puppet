# Puppet
Some puppet modules I wrote. Most of them are intended for CentOS but should work with Debian.

Most of them are intended to work with hiera files.

## myhaproxy
HAProxy classes based on puppetlabs/proxy to be able to handle haproxy through hiera files

## letsencrypt
letsencrypt installation for RedHat-like and Debian 7/8

## myfirewall
firewall classes based on puppetlabs/firewall to be able to handle creation of firewall rules through hiera files

### geoip
geoip configuration to ban or authorize IPs based on countries. I compiled the module for my kernel, you need to do the same for yours.

## mymcollective
RedHat only. Install and configure mcollective based on puppet repository packages.

## mysudo
Class to add sudo users through hiera files.
