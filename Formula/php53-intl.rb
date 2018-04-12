require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Intl < AbstractPhp53Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "19ef8b61281e56ab721dd2e12f11d23ffd828acb288a338ed9f72536e75fa076" => :sierra
    sha256 "452a16744457ab565e4964dad8d0a62fc219b1f6d691e00bb82a2c0cdf92a81a" => :el_capitan
    sha256 "c6527b9c94bc837331526f2dc57f2a4f09588ddcceaf7c3668fe07697ce49ebc" => :yosemite
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
