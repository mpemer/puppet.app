class tools::oracle-java-7-jdk ( $java_root='/usr/share/jdk' ) {
  $java_url='http://download.oracle.com/otn-pub/java/jdk/7u10-b18/jdk-7u10-linux-x64.tar.gz'
  $java_wget_url="wget --no-cookies --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" \"$java_url\""

  exec { 'download-oracle-jdk-7':
    command => "$java_wget_url",
    cwd => "$java_root/downloads",
    creates => "$java_root/downloads/jdk-7u10-linux-x64.tar.gz",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    require => File["$java_root/downloads"],
  }

  exec { 'unpack-java-installer':
    command => "tar xzf downloads/jdk-7u10-linux-x64.tar.gz",
    cwd => "$java_root",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "$java_root/jdk1.7.0_10",
    require => Exec['download-oracle-jdk-7'],
  }
}