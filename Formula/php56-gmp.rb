require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "5718eae1ffa9f6099be29dfe70b271aec9bc5eb2426d3f2c9f8fc321e7054bd1" => :high_sierra
    sha256 "6dec69875e0eb10b47a46d7625da87890e9c8fe48fe0eb8c340d156646ffe320" => :sierra
    sha256 "7d81f69bd7f3394ff1404e5898f115c8f80d88727d37ff693319a1509aa174fb" => :el_capitan
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

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
