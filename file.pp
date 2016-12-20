File { 
   owner => 'root',
   group => 'wheel',
   mode => '0664',
   ensure => 'file',
}

file { '/tmp/rethesh': 
   ensure => 'directory',
}

file { '/tmp/rethesh/file1': }
file { '/tmp/rethesh/file2': }
file { '/tmp/rethesh/file3':
     mode => '0775',
}
