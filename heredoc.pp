$ntp_conf = @(END)
driftfile /var/lib/ntp/drift
server tock perfer ibrust
server uk.pool.ntp.org
END
