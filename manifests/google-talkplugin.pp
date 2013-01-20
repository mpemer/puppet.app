class application::google-talkplugin ( $download_dir ) {

  # Dependencies
  Class[app::google-chrome] <- File[$download_dir]
 
  # Definition
  app::deb-install::install { 'google-talkplugin':
    download_dir => $download_dir,
    package_name => 'google-talkplugin',
    package_url  => 'https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb',
    deb_name     => 'google-talkplugin_current_amd64.deb',
  } 

}