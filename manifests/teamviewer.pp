class application::teamviewer ( $download_dir ) {

  # Dependencies
  Class[app::teamviewer] <- File[$download_dir]
  Class[app::teamviewer] <- Package['libc6-i386']
  Class[app::teamviewer] <- Package['lib32asound2']
  Class[app::teamviewer] <- Package['lib32z1']
 
  # Definition
  app::deb-install::install { 'teamviewer':
    download_dir => $download_dir,
    package_name => 'teamviewer',
    package_url  => 'http://www.teamviewer.com/download/version_8x/teamviewer_linux_x64.deb',
    deb_name     => 'teamviewer_linux_x64.deb',
  } 

}