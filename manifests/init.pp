# == Class: defaults
#
class defaults (
  Struct[{
    defaults => Hash,
    hash     => Hash,
    list     => Array[String],
  }] $packages,
) inherits ::defaults::params {

  # Root account.
  include ::defaults::root_user

  ## SSH keys.
  $sshkey_defaults = hiera('defaults::sshkey::defaults', {})
  $sshkeys         = hiera_hash('defaults::sshkeys', {})
  create_resources('sshkey', $sshkeys, $sshkey_defaults)

  # User Accounts.
  $useraccount_defaults = hiera('defaults::useraccount::defaults', {})
  $useraccounts         = hiera_hash('defaults::useraccounts', {})
  create_resources('defaults::useraccount', $useraccounts, $useraccount_defaults)

  # Users.
  $user_defaults = hiera('defaults::user::defaults', {})
  $users         = hiera_hash('defaults::users', {})
  create_resources('user', $users, $user_defaults)

  # Groups.
  $groups = hiera_array('defaults::groups', [])
  group { $groups:
    ensure => present,
  }

  # Packages.
  create_resources('package', $packages['hash'], $packages['defaults'])

  ensure_packages($packages['list'])

  # Hosts.
  $host_defaults = hiera('defaults::host::defaults', {})
  $hosts         = hiera_hash('defaults::hosts', {})
  create_resources('host', $hosts, $host_defaults)

  # Crons.
  $cron_defaults = hiera('defaults::cron::defaults', {})
  $crons         = hiera_hash('defaults::crons', {})
  create_resources('cron', $crons, $cron_defaults)

  # Execs.
  $exec_defaults = hiera('defaults::exec::defaults', {})
  $execs         = hiera_hash('defaults::execs', {})
  create_resources('exec', $execs, $exec_defaults)

  # Files.
  $files_defaults = hiera('defaults::file::defaults', {})
  $files          = hiera_hash('defaults::files', {})
  create_resources('file', $files, $files_defaults)

  # Mounts.
  $mounts_defaults = hiera('defaults::mount::defaults', {})
  $mounts          = hiera_hash('defaults::mounts', {})
  create_resources('mount', $mounts, $mounts_defaults)

  # Scripts.
  $script_defaults = hiera('defaults::script::defaults', {})
  $scripts         = hiera_hash('defaults::scripts', {})
  create_resources('defaults::script', $scripts, $script_defaults)

  # Certificates.
  $cert_defaults = hiera('defaults::certs::defaults', {})
  $certs         = hiera_hash('defaults::certs', {})
  create_resources('defaults::cert', $certs, $cert_defaults)

  # Services.
  $service_defaults = hiera('defaults::service::defaults', {})
  $services         = hiera_hash('defaults::services', {})
  create_resources('service', $services, $service_defaults)

}

