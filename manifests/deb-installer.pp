class app::deb-installer {
	define install ($download_dir = '/var/downloads', $package_name, $package_url, $deb_name) {
	  exec { "deb-download-$package_name":
	    command     => "wget -O $download_dir/$deb_name $package_url",
	    path        => ['/bin', '/usr/bin', '/usr/sbin'],
	    creates     => "$download_dir/$deb_name",
	    subscribe   => File[$download_dir],
	    logoutput   => true,
	  }
	  exec { "deb-install-$package_name":
	    command     => "dpkg -i $deb_name || apt-get -y -f install",
	    cwd         => "$download_dir",
	    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
	    unless      => "dpkg -s $package_name",
	    subscribe   => Exec["deb-download-$package_name"],
	    logoutput   => true,
	  }	
	}
}