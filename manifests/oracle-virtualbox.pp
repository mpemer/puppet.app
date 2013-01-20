class application::oracle-virtualbox ( $download_dir ) {

  # Dependencies
  Class[app::oracle-virtualbox] <- File[$download_dir]
  Class[app::oracle-virtualbox] <- Package['libqt4-opengl']
  Class[app::oracle-virtualbox] <- Package['libsdl1.2debian']

  # Definition
  app::deb-install::install { 'oracle-virtualbox':
    download_dir => $download_dir,
    package_name => 'virtualbox-4.2',
    package_url  => 'http://dlc.sun.com.edgesuite.net/virtualbox/4.2.6/virtualbox-4.2_4.2.6-82870~Ubuntu~quantal_amd64.deb',
    deb_name     => 'virtualbox-4.2_4.2.6-82870~Ubuntu~quantal_amd64.deb',
  } 

}