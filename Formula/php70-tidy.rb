require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 18

  bottle do
    sha256 "7ef6b8c4e6e5e076fdfcea8f0d020b69ded311e6eaf2197f26ef9a7ceed9030f" => :high_sierra
    sha256 "400fbda955b2ea591f9f2a70e0c0bf4b21b20b4056885cbd2855e63c23d09538" => :sierra
    sha256 "86cae046cd099e20f150e3a1a7795d1cae7d35152e7200a99f69e89de15c4dfa" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
