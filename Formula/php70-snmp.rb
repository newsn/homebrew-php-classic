require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 18

  bottle do
    sha256 "8bcf9beb5604fd17d76e0bd12534908176a25db89d20a131437b268f3f21b619" => :high_sierra
    sha256 "e9aa7143973f893f0749b8a63ab81047dd4a2897cba4e747e186d90a8930df82" => :sierra
    sha256 "6b00751dc16c98011fc8c470437919f8b1d1ccbc0cd046332d2281f65b73f884" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

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
