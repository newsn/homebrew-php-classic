class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "https://www.adminer.org"
  url "https://github.com/vrana/adminer/releases/download/v4.6.2/adminer-4.6.2.php"
  sha256 "2b3e5e87ed1214288378fc272c1ba0497ec2f1128444e3a581eabd435f5575b9"

  bottle do
    cellar :any_skip_relocation
    sha256 "9abd7ee3578c322c9710d7f2d095ebe7a844303a950ddccb7bb253c1254adfee" => :high_sierra
    sha256 "9abd7ee3578c322c9710d7f2d095ebe7a844303a950ddccb7bb253c1254adfee" => :sierra
    sha256 "9abd7ee3578c322c9710d7f2d095ebe7a844303a950ddccb7bb253c1254adfee" => :el_capitan
  end

  def install
    pkgshare.install "adminer-"+version+".php" => "index.php"
  end

  def caveats; <<~EOS
    Note that this formula will NOT install MySQL or any other
    database. It is not required since you might want to get
    connected to a remote database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance):

      Alias /adminer #{HOMEBREW_PREFIX}/share/adminer
      <Directory "#{HOMEBREW_PREFIX}/share/adminer/">
        Options None
        AllowOverride None
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>

    Then, open http://localhost/adminer
    EOS
  end

  test do
    system "php", "-l", "#{pkgshare}/index.php"
  end
end
