require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 9
    sha256 "5811ee55da4d43714b6bb60186c6b9cfc76b8b5fcdc1e51b947a58f535f0c5f8" => :el_capitan
    sha256 "671f02cadcc78fae2ac4556fcd09e08c29bf809a55e0ddae2e451996c985c314" => :yosemite
    sha256 "d4d0e51222c03633d3a1710624079d8913e29f33e05ed6091a04f78b07f79d22" => :mavericks
  end

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-snmp=#{Formula["net-snmp"].opt_prefix}"
    system "make"
    prefix.install "modules/snmp.so"
    write_config_file if build.with? "config-file"
  end
end








