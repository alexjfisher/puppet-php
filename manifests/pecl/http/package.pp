# == Class: php::pecl::http::package
#
# Install the PHP http extension
#
# Will also install contrib packages required to
# compile the extension on the machine
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of http to install
#
# === Examples
#
#  include php::pecl::http::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::http::package {

  package { 'pecl_http':
    ensure   => installed,
    provider => pecl,
    pipe     => 'echo 'y
    y
    n'';
  }

  package { ['libcurl4-openssl-dev', 'libmagick++-dev']:
    ensure => installed;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['libcurl4-openssl-dev']
    -> Package['libmagick++-dev']
    -> Package['php5-dev']
    -> Package['pecl_http']

  if defined(Service['apache2']) {
    Package['pecl_http'] ~> Service['apache2']
  }

}