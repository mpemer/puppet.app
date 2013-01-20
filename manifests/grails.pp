class tools::grails ($grails_root = '/usr/share/grails', $grails_version='2.2.0', $default = true) {

  # Dependencies
  Class['java'] -> Class['grails']

  # Install grails
  $grails_installer="grails-$grails_version.zip"
  $grails_installer_path="$grails_root/downloads/$grails_installer"
  $grails_installer_url="http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/$grails_installer"

  # Make sure we have the base directories,
  # but don't be rude since we could have more than one version
  if defined(File["$grails_root"]) {
    notify("$grails_root already defined, skipping.")
  }
  else {
    file { "$grails_root": ensure => directory }
  }

  if defined(File["$grails_root/downloads"]) {
    notify("$grails_root/downloads already defined, skipping.")
  }
  else {
    file { "$grails_root/downloads": ensure => directory }
  }

  exec { "download-grails-$grails_version":
    command => "wget -O $grails_installer_path $grails_installer_url",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "$grails_installer_path",
    require => File["$grails_root/downloads"],
  }

  exec { "unpack-grails-installer-$grails_version":
    command => "unzip $grails_installer_path",
    cwd => "$grails_root",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "$grails_root/grails-$grails_version",
    require => Exec["download-grails-$grails_version"],
  }

  if $default == true {
    file { "grails-home-link-$grails_version":
      ensure => link,
      path => "$grails_root/latest",
      target => "$grails_root/grails-$grails_version",
      require => Exec["unpack-grails-installer-$grails_version"],
    }

    file { "/etc/profile.d/grails.sh":
      content => "export GRAILS_HOME=$grails_root/latest
export PATH=\$GRAILS_HOME/bin:\$PATH
",
    }
  }

}
