# puppet

USE SUDO INFORNT ON THE PUPPET COMMAND


Defining configurations needs as resources
Set the correct the service names
Restarting the services
Working with Modules and Classes
Working with files and Templates
Hiera the single Source of Truth
Server and Puppet Enterprise
Understanding the Resources and it's relationships 
idempotent [ idem = the same and potent = power ]

https://docs.puppet.com/guides/style_guide.html - puppet style guide


puppet agent - runs on the client and send facts to the server

puppet server - Collects facts from agents and 	complies a catalog for the agent to apply 

puppet apply - a combination of puppet agent and puppet server allowing the client to run in standalone mode 


Puppet Resources : The big three

package 
File
service 

puppet Standard library
Users and groups
Hosts
SSH_Authorized_keys
Resources default



sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo wget https://apt.puppetlabs.com/puppetlabs-release-pc1.trusty.deb
sudo dpkg -i puppetlabs-release-pc1.trusty.deb

puppet-agent is version 4 and puppet might be version 3

puppet-agent on puppet and puppet 4 uses puppet collections 

puppet --version
puppet agent --version
puppet config print 
puppet config print confdir
puppet config print vardir
puppet config print { configdir rundir  runinterval certname }
puppet config print { configdir vardir  ssldir }
puppet resource user 
puppet resource user bob
facter 

secure_path in /etc/sudoers update it with /opt/puppetlabs/bin [ /etc/puppetlabs/puppet/puppet.conf ]


sudo puppet  resource user rethesh --edit


user { 'fred':
    ensure => 'present',
    managehome => true,
    uid => '2001'
}


Puppet Manifests [Text file with .pp suffix . contain puppet code ]

site.pp [ server -agent puppet arch ]

init.pp [ intial Manifest that is loaded with each module ]



Contain puppet code 

site.pp/init.pp

puppet apply 

notify { 'Hello World': }

puppet parser validate helloworld.pp [ validate the code ]

puppet apply helloworld.pp 

puppet apply -e "notify { 'Hello World': }"

sudo puppet  resource service puppet 

service { 'puppet': 
   ensure => 'stopped',
   enable => false,
}

[vagrant@pupppet ~]$ sudo puppet resource service puppet
service { 'puppet':
  ensure => 'stopped',
  enable => 'false',
}
[vagrant@pupppet ~]$ sudo puppet resource service puppet > puppet-service.pp
[vagrant@pupppet ~]$ puppet parser validate puppet-service.pp 
[vagrant@pupppet ~]$ 

[vagrant@pupppet ~]$ sudo puppet apply puppet-service.pp 
Notice: Compiled catalog for pupppet.xperio in environment production in 0.10 seconds
Notice: /Stage[main]/Main/Service[puppet]/ensure: ensure changed 'running' to 'stopped'
Notice: Finished catalog run in 0.15 seconds
[vagrant@pupppet ~]$ 


puppet module list

puppet module install theurbanpenguin/puppet_vim


puppet-vim.pp
include puppet_vim

puppet parser validate puppet-vim.pp

[vagrant@pupppet ~]$ puppet apply -e "include puppet_vim"

user { 'test': 
   managehome => true,
   uid => '2002',
   ensure => 'present',
}





puppet resource user test

puppet describe --list [ all Resources type ]

puppet describe  user

puppet describe  notify

puppet describe  file

puppet describe  user --short

puppet describe file | grep namevar 






file  { '/etc/motd': 
   ensure => 'file',
   content => "Welcome to My Server\n",
}

file  { 'Message File': 
   ensure => 'file',
   content => "Welcome to My Server\n",
   path    => '/etc/motd',
}



sudo puppet apply motd.pp 


Resource - Package,service and file 


package - ensure => installed, absent,purged,latest, 4.1

provider => yum

service - ensure => 'running', 'stopped'

ensure => true or false


[vagrant@pupppet ~]$ cat ntp.pp 
$ntp_conf = '#Managed by puppet
server 192.168.0.3 ibusrt
driftfile /var/lib/ntp/drift
'

package { 'ntp': }

file { '/etc/ntp.conf':
    ensure => 'file',
    content => $ntp_conf,
    owner => 'root',
    group => 'wheel',
    mode => '0664',
}

service {'NTP_service':
    ensure => 'running',
    enable => true,
    name => 'ntpd',
}


puppet parser validate ntp1.pp

sudo puppet module install puppetlabs/stdlib

group { 'admins': }

user { 'bob' :
    ensure     => 'present',
    managehome => true,
    groups     => ['wheel','users'],
    password   => pw_hash('Password1','SHA-512','salt'),
}


host { 'timeserver':
    ip => '192.168.0.3',
    host_aliases => 'tock',
}

ssh_authorized_key { 'tux@centos7':
            user => 'tux',
            type => 'ssh-rsa',
            key  => 'sjksksssksk'
}

group { 'admins':
      ensure => 'present'
}

user { 'bob' :
    ensure     => 'present',
    managehome => true,
    groups     => ['wheel','users'],
    password   => pw_hash('Password1','SHA-256','salt'),
}
~                                       

vagrant@pupppet ~]$ cat hosts.pp 
host { 'timeserver':
    ip => '192.168.0.31',
    host_aliases => 'tock',
}
[vagrant@pupppet ~]$ 


[vagrant@pupppet ~]$ cat ssh.pp 
ssh_authorized_key { 'bob@localhot' :
           user => 'bob',
           type => 'ssh-rsa',
           key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKogxTKEGUySBeXFUllgzTea7SI8StkXsDCnlPp4R6P6VtC/3xxBlKStObISS/ifG4VVqKs6Je1LTahEsKI8d3jZp657MgzDfbbPiWD7epi6b6zWDTBgMyBEKTiks6g0MO7hMlvuqVud3l4WOwSsbxit6DIL+RNHL3KrH+aVpGGHRjx2Loh0L4l1QR9QFYSVRaL06K45meaGuRQ9QVpj5zinEWjtOrKnMTA4K6m+Wbf1kP+pQaQsGTAk4eT5dlCQ6XCAfcv02Pnxyr6pkqbHYSFaxDiRzzWCyUfqWDoiHC3v/Cxn5I7VWMaDsgARuxwo8EhRY1b7N29tHJaibezeZV',
}
[vagrant@pupppet ~]$ 

[vagrant@pupppet ~]$ cat file.pp 
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
[vagrant@pupppet ~]$ 


$admingroups = ['wheel', 'admin']
notify {"The first group is ${admingroups[0]}": }
$user = { 'username' => 'bob', 
'userid' => '2011', }
notify {"The user's name is ${user['username']}": }


$ntp_conf = @(END)
driftfile /var/lib/ntp/drift
server tock perfer ibrust
server uk.pool.ntp.org
END





Puppet - 3


#Managed ntp  on linux
$ntp_conf = "#Managed by puppet
server 192.168.0.3 ibusrt perfer
server 192.168.0.4
driftfile /var/lib/ntp/drift
"

$ntp_service = 'ntpd'
$admingroup = 'wheel'

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


Puppet - 4
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
~                   


[vagrant@pupppet ~]$ cat play.pp 
#This is simple test
$ntp_service = 'ntpd'
notify { $ntp_service : }
notify { "The ${ntp_service} is running" : }
$admingroups = ['wheel','admin']
$user = {
       'username' => 'bob',
       'uid' => '1022'
}
notify { $user['username'] : }
notify { "The user name is ${user['username']}" : }
[vagrant@pupppet ~]$ 


puppet - 4

facter command 

facter os 

in code

facts['os']['family']  [ deprecated - $osfamily or $::osfamily]

$display = @("END")

Family: ${facts['os']['family']}
OS: ${facts['os']['name']}
Version: ${facts['os']['release']['full']}
END

notify { display  : }
~                        


if $facts['os']['family'] == 'Redhat' {
    notify { 'Red Hat' : }
} #Modern facts
if $facts['osfamily'] == 'Redhat' {
    notify { 'Red Hat' : }
} #Legacy facts
~                     

if/else - if/elsif/else unless/else , case,  selector


Puppet -4 [ modern facts - facter and puppet facts - legancy facts ]



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
~                                                                                                                                                                            
~                                                                                                                                                                            
"ntp3.pp" 39L, 660C

$facts['os']['family'] =~ /RedHat/
$facts['os']['family'] =~ /^RedHat$/
$facts['networking']['fqdn'] =~ /^www\d/
$facts['networking']['fqdn'] =~ /\.example\.com$/


echo ( $facts['partitions']) | $devname, $devprops | { if $devprops['mount'] {
notify { "Device: ${devname} is ${devprops['size']}": }
}



ntp_service = $facts['os']['family'] ? {
'redhat' => 'ntpd',
'debian' => 'ntp',
}
              

puppet apply --ordering=random ntp4.pp


vagrant@pupppet ~]$ cat ntp.pp 
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

service {'NTP_service':
    ensure => 'running',
    enable => true,
    name => 'ntpd',
    require => File['/etc/ntp.conf'],
}
\

Autorequires
puppet  describe user | grep -A5 Autorequires



Meta-Paramter = Notify or Subscribe 


Package['ntp'] -> File['/etc/ntp.conf'] ~> Service['NTP_S']
















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
    notify => Service['NTP_Service'],
}

service {'NTP_service':
    ensure => running,
    enable => true,
    name => $ntp_service,
    subscribe => File['/etc/ntp.conf']
}
~                        


~                                 
