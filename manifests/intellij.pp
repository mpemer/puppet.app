class application::intellij ($intellij_root = '/usr/share/intellij' ) {

  # Install Sublime Edit
  $intellij_url = 'http://download-ln.jetbrains.com/idea/ideaIC-12.0.2.tar.gz'
  $intellij_installer_path = "$intellij_root/downloads/ideaIC-12.0.2.tar.gz"

  file { [
    $intellij_root,
    "$intellij_root/downloads",
    ]:
    ensure    => directory,
    owner     => root,
    group     => root,
  }

  exec { "download-intellij-$intellij_root":
    command   => "wget -O $intellij_installer_path $intellij_url",
    timeout   => 3000,
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => "$intellij_installer_path",
    require   => File["$intellij_root/downloads"],
  }

  exec { "unpack-intellij-installer-$intellij_root":
    command   => "tar xzf $intellij_installer_path",
    cwd       => "$intellij_root",
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => [
                "$intellij_root/idea-IC-123.123",
              ],
    require   => Exec["download-intellij-$intellij_root"],
  }

  file { "/etc/profile.d/intellij.sh":
    content => "export PATH=$intellij_root/idea-IC-123.123/bin:\$PATH",
  }

  file { '/usr/share/applications/IDEA.desktop':
    content => "[Desktop Entry]
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=$intellij_root/idea-IC-123.123/bin/idea.sh %U
Icon=$intellij_root/idea-IC-123.123/bin/idea.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=GNOME;GTK;Utility;TextEditor;
MimeType=text/plain;
"
  }

}