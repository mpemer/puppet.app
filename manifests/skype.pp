class application::skype ( $download_dir ) {

  # Dependencies
  Class[app::google-chrome] <- File[$download_dir]
  Class[app::google-chrome] <- Package['libasound2']
  Class[app::google-chrome] <- Package['libc6']
  Class[app::google-chrome] <- Package['libgcc1']
  Class[app::google-chrome] <- Package['libqt4-dbus']
  Class[app::google-chrome] <- Package['libqt4-network']
  Class[app::google-chrome] <- Package['libqt4-xml']
  Class[app::google-chrome] <- Package['libqtcore4']
  Class[app::google-chrome] <- Package['libqtgui4']
  Class[app::google-chrome] <- Package['libqtwebkit4']
  Class[app::google-chrome] <- Package['libstdc++6']
  Class[app::google-chrome] <- Package['libx11-6']
  Class[app::google-chrome] <- Package['libxext6']
  Class[app::google-chrome] <- Package['libxss1']
  Class[app::google-chrome] <- Package['libxv1']
  Class[app::google-chrome] <- Package['libssl1.0.0']

  # Definition
  $deb_name='skype-ubuntu-precise_4.1.0.20-1_i386.deb'

  app::deb-install::install { 'skype':
    download_dir => $download_dir,
    package_name => 'skype',
    package_url  => 'http://download.skype.com/linux/$deb_name',
    deb_name     => $deb_name,
  } 

}