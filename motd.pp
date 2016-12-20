file  { '/etc/motd': 
   ensure => 'file',
   content => "Welcome to My Server\n",
}
