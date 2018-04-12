class Phpmyadmin3 < Formula
  desc "Web-based administration tool for MySQL"
  homepage "http://www.phpmyadmin.net"
  url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_3_5_8_2.tar.gz"
  sha256 "2c97bd076a923c3742caa28fc343e4d63294b32cf68f7af79fe8b7eb2a8012dc"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "adbdcdd81925fdc92dc89006a6d37d1bf86e935f99a1f16384e97adf36907689" => :sierra
    sha256 "59ac48634dd9062ca110cdffc4b5111579d883f4e01170d910621f0fdb544b4c" => :el_capitan
    sha256 "c4c3219b9ef0c21f9cffa5baf736564b720e2ebe1b26dbd550e8164d6d84815f" => :yosemite
    sha256 "278697e6a857eaf6ae174b62d04ff2df7abecaeaf8f76bbb4623c154f717ad7e" => :mavericks
  end

  if build.with? "mcrypt"
    depends_on "php53-mcrypt" if Formula["php53"].linked_keg.exist?
    depends_on "php54-mcrypt" if Formula["php54"].linked_keg.exist?
    depends_on "php55-mcrypt" if Formula["php55"].linked_keg.exist?
    depends_on "php56-mcrypt" if Formula["php56"].linked_keg.exist?
    depends_on "php70-mcrypt" if Formula["php70"].linked_keg.exist?
  end

  unless MacOS.prefer_64_bit?
    option "without-mcrypt", "Exclude the php-mcrypt module"
  end

  def install
    (share+"phpmyadmin3").install Dir["*"]

    unless File.exist?(etc+"phpmyadmin3.config.inc.php")
      cp (share+"phpmyadmin3/config.sample.inc.php"), (etc+"phpmyadmin3.config.inc.php")
    end
    ln_s (etc+"phpmyadmin3.config.inc.php"), (share+"phpmyadmin3/config.inc.php")
  end

  def caveats; <<~EOS
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin3 #{HOMEBREW_PREFIX}/share/phpmyadmin3
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin3/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>
    Then, open http://localhost/phpmyadmin3

    More documentation : file://#{share}/phpmyadmin3/doc/

    Configuration has been copied to #{etc}/phpmyadmin3.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end

  test do
    assert File.exist?("#{etc}/phpmyadmin3.config.inc.php")
  end
end
