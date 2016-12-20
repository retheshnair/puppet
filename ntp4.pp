$ntp_conf = '#Managed by puppet
server 192.168.0.3 ibusrt
driftfile /var/lib/ntp/drift
'

package { 'ntp': 
       before => File['/etc/ntp.conf'],
}

file { '/etc/ntp.conf':
    ensure => 'file',
    content => $ntp_conf,
    owner => 'root',
    group => 'wheel',
    mode => '0664',
    require => Package['ntp],
    before => Service['NTP_Service'],
}

service {'NTP_Service':
    ensure => 'running',
    enable => true,
    name => 'ntpd',
    require => File['/etc/ntp.conf'],
}
