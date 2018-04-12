require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 19

  bottle do
    sha256 "4fe46b62f46a0c75fe768380d96fde0950554b21d8790a1581eeb5aff6beb366" => :high_sierra
    sha256 "997bd18ee474c0e78251615732daf4a7004f0ddd96673c5c4f6615632aaacbd1" => :sierra
    sha256 "6fd6684957639a1f859948ae23dfc6ac21c267909df739ec3c953aca984b3128" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
