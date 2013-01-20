class application::balsamiq ( $download_dir ) {

  # Dependencies
  File[$download_dir] -> Class[app::balsamiq]
  Class[adobeair]     -> Class[app::balsamiq]

  # Definition
  $deb_name='MockupsForDesktop64bit.deb'

  app::deb-install::install { 'balsamiq':
    download_dir => $download_dir,
    package_name => 'balsamiq',
    package_url  => "http://builds.balsamiq.com/b/mockups-desktop/$deb_name",
    deb_name     => $deb_name,
  } 

}