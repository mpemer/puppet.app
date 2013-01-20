class application::ubuntu-tweak ( $download_dir ) {

  # Dependencies
  File[$download_dir] -> Class[app::ubuntu-tweak]

  # Definition
  $package_name='ubuntu-tweak'
  $deb_name='ubuntu-tweak_0.8.3-1~precise1_all.deb'

  app::deb-install::install { $package_name:
    download_dir => $download_dir,
    package_name => $package_name,
    package_url  => "https://launchpad.net/ubuntu-tweak/0.8.x/0.8.3/+download/$deb_name",
    deb_name     => $deb_name,
  } 

}