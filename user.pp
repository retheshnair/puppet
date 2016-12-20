user { 'bob' :
    ensure     => 'present',
    managehome => true,
    groups     => ['wheel','users'],
    password   => pw_hash('Password1','SHA-512','salt'),
}
