each ( $facts['partitions']) | $devname, $devprops | {
  if $devprops['mount'] {
        notify { "Device: ${devname} is ${devprops['size']}": }
}
}
