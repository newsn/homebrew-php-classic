require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "0a3a8aacdf11a035ff242248239393e6b08cc2a7811a0bbb3622e1f34f576a00" => :high_sierra
    sha256 "0943e71341586dce5acf2187cd30023cf3699d04487ec2300e99de9cc8d6d0c2" => :sierra
    sha256 "cedb825f01104e0ece70b41306230a2b3ff09ad06ce7d009a940ebff97b9f310" => :el_capitan
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
