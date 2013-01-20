class application::google-chrome ( $download_dir ) {

  # Dependencies
  Class[app::google-chrome] <- File[$download_dir]
  Class[app::google-chrome] <- Package['libgconf2-4']
  Class[app::google-chrome] <- Package['libnss3-1d']
  Class[app::google-chrome] <- Package['libxss1']
 
  # Definition
  app::deb-install::install { 'google-chrome':
    download_dir => $download_dir,
    package_name => 'google-chrome-stable',
    package_url  => 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb',
    deb_name     => 'google-chrome-stable_current_amd64.deb',
  } 

}