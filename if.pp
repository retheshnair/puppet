if $facts['os']['family'] == 'Redhat' {
    notify { 'Red Hat' : }
} #Modern facts
#if $facts['osfamily'] == 'Redhat' {
#    notify { 'Red Hat' : }
#}
