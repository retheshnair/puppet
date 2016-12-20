$admingroups = ['wheel', 'admin']
notify {"The first group is ${admingroups[0]}": }
$user = { 'username' => 'bob', 
'userid' => '2011', }
notify {"The user's name is ${user['username']}": }
