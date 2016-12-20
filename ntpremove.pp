package {'ntp':
       ensure => 'purged',
}

file { '/etc/ntp.conf':
        ensure => 'absent',
}
