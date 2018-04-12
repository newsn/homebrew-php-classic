require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 14

  bottle do
    sha256 "3cd89c97a94bd7ee0550240a132d485488729f80a466a4ce09fe513516606fcd" => :high_sierra
    sha256 "918184b314eea190e3e8286cae667f12a604539b2ed5883f1b054b76111d6e39" => :sierra
    sha256 "3d68d07fcfcd2e3df7e12749fce0c11fa6b81b6e8379dbc04ead9a5eb7462914" => :el_capitan
  end

  depends_on "icu4c"

  needs :cxx11

  def install
    ENV.cxx11
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["icu4c"].prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
