class application::sublime-text-puppet ( $user, $sublime_packages_dir ) {
  exec { 'sublime-text-puppet':
    user    => $user,
    command => "git clone https://github.com/eklein/sublime-text-puppet.git && mv sublime-text-puppet/Puppet $sublime_packages_dir/Puppet && rm -fR /tmp/sublime-text-puppet",
    cwd     => '/tmp',
    path    => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "$sublime_packages_dir/Puppet",
  }	
}
