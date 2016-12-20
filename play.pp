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
