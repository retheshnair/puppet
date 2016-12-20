#Managed ntp  on linux
$ntp_conf = @(END)
#Managed by puppet
server 192.168.0.3 ibusrt perfer
server 192.168.0.4
driftfile /var/lib/ntp/drift
END

$ntp_service = 'ntpd'
$admingroup = 'wheel'

package { 'ntp': 
     before => File['/etc/ntp.conf'],
}

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
