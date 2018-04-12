require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Snmp < AbstractPhp54Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 1
    sha256 "80d82caafda71a76a5f1193716c0dffd94b8c71ff00195fba0347762a7bfc447" => :yosemite
    sha256 "096c6e357bff4c76c548eb2ecff41e4b08fbc144aa24f569bbeff79d1ff7af10" => :mavericks
    sha256 "f74ca5d4b4e085c1f1e3fcad6cf15fa75de625cff9fb7eb81b9a734e6974d03c" => :mountain_lion
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
