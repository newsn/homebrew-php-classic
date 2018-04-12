require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Snmp < AbstractPhp53Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "e8525de82f43ac0041ad431dc9c203f98f5a5296527c727e8d5b4ca2dcf7b4d6" => :yosemite
    sha256 "a92955b68c219373caae98cd4f7ea26959a42d48ea479a054a976f03b53eaf85" => :mavericks
    sha256 "a1bba69ef645f0c0e5449805e117896f7992ed86248fa41d6760caf5dd054038" => :mountain_lion
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
