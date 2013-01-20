class tools::oracle-java-6-jdk ( $java_root='/usr/share/jdk' ) {
  $java_url='http://download.oracle.com/otn-pub/java/jdk/6u38-b05/jdk-6u38-linux-x64.bin'
  $java_wget_url="wget --no-cookies --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" \"$java_url\""

  exec { 'download-java':
    command => "$java_wget_url",
    cwd => "$java_root/downloads",
    creates => "$java_root/downloads/jdk-6u38-linux-x64.bin",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    require => File["$java_root/downloads"],
  }

  file { "$java_root/downloads/jdk-6u38-linux-x64.bin":
    mode => 700,
    require => Exec['download-java'],
  }

  exec { 'run-java-6-installer':
    command => "$java_root/downloads/jdk-6u38-linux-x64.bin",
    cwd => "$java_root",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "$java_root/jdk1.6.0_38",
    require => File["$java_root/downloads/jdk-6u38-linux-x64.bin"],
  }
}