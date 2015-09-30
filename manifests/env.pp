class midonet::env(
  $jvm_env = undef,
  $mn_env = undef,
) {

  if $jvm_env {
    file { '/etc/midolman/midolman-env.sh':
      ensure => file,
      mode   => '0444',
      source => "/etc/midolman/$jvm_env",
      notify => Service['midolman'],
    }
  }

  if $mn_env {
    exec { "set mn to $mn_env":
      command => "mn-conf template-set -h local -t $mn_env",
      unless  => "mn-conf template-get -h local | grep -q $mn_env",
      path    => '/bin:/usr/bin:/sbin:/usr/sbin',
      notify  => Service['midolman'],
    }
  }
}
