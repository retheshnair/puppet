#Managed ntp  on linux
$ntp_conf = "#Managed by puppet
server 192.168.0.3 ibusrt perfer
server 192.168.0.4
driftfile /var/lib/ntp/drift
"

case $facts['os']['family'] {
    'RedHat': {
      $ntp_service = 'ntpd'
      $admingroup = 'wheel'
     }
    'Debian': {
      $ntp_service = 'ntp'
      $admingroup = 'sudo'
     }

 default : {
     fail("Your ${facts['os']['family']} is not support")
}
}
package { 'ntp': }

File {
    owner => root,
    group => $admingroup,
    mode => '0664',
    ensure => 'file',
}

file { '/etc/ntp.conf':
    content => $ntp_conf,
}

service {'NTP_service':
    ensure => running,
    enable => true,
    name => $ntp_service,
}
