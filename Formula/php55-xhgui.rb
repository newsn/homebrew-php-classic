require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xhgui < AbstractPhp55Extension
  include Language::PHP::Composer

  init
  desc "Graphical interface for XHProf data built on MongoDB"
  homepage "https://github.com/perftools/xhgui"
  url "https://github.com/perftools/xhgui/archive/v0.4.0.tar.gz"
  sha256 "356e6fc46158d827aa6168d55e7de55ea16f539dbabeab5eb5085a9d03f7bb07"
  head "https://github.com/perftools/xhgui.git"

  depends_on "mongodb"
  depends_on "php55-mcrypt"
  depends_on "php55-mongo"
  depends_on "php55-xhprof"

  def install
    prefix.install %w[composer.json composer.lock install.php cache config src external webroot]
    (prefix + "cache").chmod 0777
    Dir.chdir prefix
    cp "config/config.default.php", "config/config.php"
    composer_install
  end

  def caveats
    caveats = <<-EOS

  Post Install
  ============

  * Restart your webserver to load the xhprof.so module dependency.
  * Point your webserver to folder "#{opt_prefix}/webroot"
  * Update you mongodb configuration (username, password, host and/or port)
    if you're not using the default values:

    #{opt_prefix}/config/config.php

  * Add indexes to mongodb for increased for performance.

     $ mongo xhprof

     db.results.ensureIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )
     db.results.ensureIndex( { 'profile.main().wt' : -1 } )
     db.results.ensureIndex( { 'profile.main().mu' : -1 } )
     db.results.ensureIndex( { 'profile.main().cpu' : -1 } )
     db.results.ensureIndex( { 'meta.url' : 1 } )

  Profiling
  =========

  * For system wide random profiling, you can add the following directive in php.ini:

    auto_prepend_file=#{opt_prefix}/external/header.php

  * If you prefer to configure profiling per virtual host:

    Using Apache:

    <VirtualHost *:80>
        php_admin_value auto_prepend_file "#{opt_prefix}/external/header.php"
        DocumentRoot "#{opt_prefix}/webroot/"
        ServerName site.localhost
    </VirtualHost>

    Using nginx:

    server {
        listen 80;
        server_name site.localhost;
        root #{opt_prefix}/webroot/;
        fastcgi_param PHP_VALUE "auto_prepend_file=#{opt_prefix}/external/header.php";
     }
EOS
    caveats
  end
end
