class application::adobeair ( $adobeair_root = '/usr/share/adobeair' ) {

  # Dependencies
  Package['gnome-keyring'] -> Class[app::adobeair]
  Package['flashplugin-installer'] -> Class[app::adobeair]
  
  # Install adobeair Edit
  $adobeair_installer='AdobeAIRInstaller.bin'
  $adobeair_url = "http://airdownload.adobe.com/air/lin/download/2.6/$adobeair_installer"
  $adobeair_installer_path = "$adobeair_root/downloads/$adobeair_installer"

  file { [
    $adobeair_root,
    "$adobeair_root/downloads",
    ]:
    ensure    => directory,
    owner     => root,
    group     => root,
  }

  exec { "download-adobeair-$adobeair_root":
    command   => "wget -O $adobeair_installer_path $adobeair_url",
    timeout   => 0,
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => "$adobeair_installer_path",
    require   => File["$adobeair_root/downloads"],
  }

  file { "$adobeair_installer_path":
    mode    => '0755',
    require => Exec["download-adobeair-$adobeair_root"],
  }

  exec { "install-adobeair-$adobeair_root":
    command   => "$adobeair_installer_path",
    cwd       => "$adobeair_root",
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => [
                "$adobeair_root/HUBBAXXX",
              ],
    require   => File["$adobeair_installer_path"],
  }

#  exec { "rename-adobeair-$adobeair_root":
#    command   => "mv \"$adobeair_root/adobeair Text 2\" $adobeair_root/adobeair-text-2",
#    path      => ['/bin', '/usr/bin', '/usr/sbin'],
#    creates   => "$adobeair_root/adobeair-text-2",
#    require   => Exec["unpack-adobeair-installer-$adobeair_root"],
#  }

#  file { "/etc/profile.d/adobeair.sh":
#    content => "export PATH=$adobeair_root/adobeair-text-2:\$PATH",
#  }

#  file { '/usr/share/applications/adobeair-text.desktop':
#    content => '[Desktop Entry]
#Name=adobeair Edit
#Comment=The Ultimate Text Editor
#Exec=/usr/share/adobeair/adobeair-text-2/adobeair_text %U
#Icon=/usr/share/adobeair/adobeair-text-2/Icon/256x256/adobeair_text.png
#Terminal=false
#Type=Application
#Encoding=UTF-8
#Categories=GNOME;GTK;Utility;TextEditor;
#MimeType=text/plain;
#'
#  }

}
