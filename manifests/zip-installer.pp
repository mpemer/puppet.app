class app::zip-installer {

  define install ($app_root, $app_url) {
    if $app_url =~ /^.*\/([^\/]*)/ {
      $app_installer = $1
    }

    $app_installer_path="$app_root/downloads/$app_installer"

    # Make sure we have the base directories,
    # but don't be rude since we could have more than one version
    if defined(File["$app_root"]) {
      notify("$app_root already defined, skipping.")
    }
    else {
      file { "$app_root": ensure => directory }
    }

    if defined(File["$app_root/downloads"]) {
      notify("$app_root/downloads already defined, skipping.")
    }
    else {
      file { "$app_root/downloads": ensure => directory }
    }

    exec { "download-$app_root-$app_url":
      command => "wget -O $app_installer_path $app_url",
      creates => "$app_installer_path",
      require => File["$app_root/downloads"],
    }

    exec { "unpack-$app_root-$app_url":
      command => "unzip -q -n $app_installer_path",
      cwd => "$app_root",
      unless => "test -d $app_root/\$(unzip -l $app_installer_path | head -4 | tail -1 | awk '{print \$4}')",
      require => Exec["download-$app_root-$app_url"],
    }

  }

}
