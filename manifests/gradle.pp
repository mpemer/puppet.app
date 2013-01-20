class app::gradle ($app_root = '/usr/share/gradle', $app_version='1.3', $default = true) {

  # Dependencies
  Class[app::gradle] <- Class[java]
 
  # Definition
  app::zip-installer::install { "gradle-$app_version":
    app_root  => $app_root,
    app_url   => "http://services.gradle.org/distributions/gradle-$app_version-all.zip",
  } 
}
