file  { 'Message File': 
   ensure => 'file',
   content => "Welcome to My Server\n",
   path    => '/etc/motd',
}
