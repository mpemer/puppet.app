class app::clojure ($app_root = '/usr/share/clojure', $app_version='1.4.0') {
  # Definition
  app::zip-installer::install { "groovy-$app_version":
    app_root  => $app_root,
    app_url   => "http://repo1.maven.org/maven2/org/clojure/clojure/$app_version/clojure-$app_version.zip",
  } 

}
