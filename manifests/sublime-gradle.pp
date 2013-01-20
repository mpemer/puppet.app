class app::sublime-gradle ( $user, $sublime_packages_dir, $ensure='installed' ) {

  # Dependencies
	Class[app::sublime-gradle] <-	Class[app::sublime]
	
	# TODO: Do we need to require installation of gradle to edit gradle files?
        # Do we care?
	#Class[app::sublime-gradle] <-	Class[gradle]

  # Definition
  case $ensure {

  	'installed', 'present', 'latest': {
		  exec { 'sublime-gradle':
		    user    => $user,
		    command => "git clone https://github.com/koizuss/sublime-gradle.git",
		    cwd     => "$sublime_packages_dir",
		    path    => ['/bin', '/usr/bin', '/usr/sbin'],
		    creates => "$sublime_packages_dir/sublime-gradle",
		  }
		  if $ensure == 'latest' {
			  exec { 'sublime-gradle-pull':
			    user    => $user,
			    command => "git pull origin master",
			    cwd     => "$sublime_packages_dir/sublime-gradle",
			    path    => ['/bin', '/usr/bin', '/usr/sbin'],
			  }
		  }
  	}

  	'absent', 'purged': {
  		file { "$sublime_packages_dir/sublime-gradle":
  		  ensure  => absent,
  		  recurse => true,
  		}
  	}
  }

}
