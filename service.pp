$ntp_service = 'ntp'

service {'NTP_service':
    ensure => 'running',
    enable => true,
    name => '$ntp_service',
}

notify {"The ${ntp_service} is up and running": }

