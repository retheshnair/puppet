$display = @("END")

Family: ${facts['os']['family']}
OS: ${facts['os']['name']}
Version: ${facts['os']['release']['full']}
END

notify { $display  : }



$facts['os']['family'] =~ /RedHat/
$facts['os']['family'] =~ /^RedHat$/
$facts['networking']['fqdn'] =~ /^www\d/
$facts['networking']['fqdn'] =~ /\.example\.com$/


