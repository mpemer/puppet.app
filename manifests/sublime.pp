class application::sublime ( $sublime_root = '/usr/share/sublime' ) {

  # Install Sublime Edit
  $sublime_url = 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1%20x64.tar.bz2'
  $sublime_installer_path = "$sublime_root/downloads/sublime.tar.bz2"

  file { [
    $sublime_root,
    "$sublime_root/downloads",
    ]:
    ensure    => directory,
    owner     => root,
    group     => root,
  }

  exec { "download-sublime-$sublime_root":
    command   => "wget -O $sublime_installer_path $sublime_url",
    timeout   => 0,
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => "$sublime_installer_path",
    require   => File["$sublime_root/downloads"],
  }

  exec { "unpack-sublime-installer-$sublime_root":
    command   => "tar xjf $sublime_installer_path",
    cwd       => "$sublime_root",
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => [
                "$sublime_root/Sublime Text 2",
                "$sublime_root/sublime-text-2",
              ],
    require   => Exec["download-sublime-$sublime_root"],
  }

  exec { "rename-sublime-$sublime_root":
    command   => "mv \"$sublime_root/Sublime Text 2\" $sublime_root/sublime-text-2",
    path      => ['/bin', '/usr/bin', '/usr/sbin'],
    creates   => "$sublime_root/sublime-text-2",
    require   => Exec["unpack-sublime-installer-$sublime_root"],
  }

  file { "/etc/profile.d/sublime.sh":
    content => "export PATH=$sublime_root/sublime-text-2:\$PATH",
  }

  file { '/usr/share/applications/sublime-text.desktop':
    content => '[Desktop Entry]
Name=Sublime Edit
Comment=The Ultimate Text Editor
Exec=/usr/share/sublime/sublime-text-2/sublime_text %U
Icon=/usr/share/sublime/sublime-text-2/Icon/256x256/sublime_text.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=GNOME;GTK;Utility;TextEditor;
MimeType=text/plain;
'
  }

}
