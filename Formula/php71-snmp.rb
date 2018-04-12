require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 19

  bottle do
    sha256 "f5498d218176ea511a2bcac6bdb8689c773c2f4bb1466b8dc28eacdb31bb1687" => :high_sierra
    sha256 "be2c1d4350e88f49604d87ff80600d579a3d6f0cef0dba4b6978ef1041831d97" => :sierra
    sha256 "5606a1e926935145d432876ee1cbe05c87260bae1a38525be1a7946642da5b61" => :el_capitan
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
