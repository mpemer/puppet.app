class app::groovy ($app_root = '/usr/share/groovy', $app_version='2.0.6', $default = true) {

  # Dependencies
 
  # Definition
  app::zip-installer::install { "groovy-$app_version":
    app_root  => $app_root,
    app_url   => "http://dist.groovy.codehaus.org/distributions/groovy-binary-$app_version.zip",
  } 

}
