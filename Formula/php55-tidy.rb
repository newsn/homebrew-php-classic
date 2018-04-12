require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 9
    sha256 "aafdc9d6b61f3fe6b42f259e011ea0063f0f22dcd2e27c6bff4a0ae516d9087d" => :el_capitan
    sha256 "64a1b7788e6a9fd4e67940d6ed0e00d16ca58169100de294c04bc0d32a24710f" => :yosemite
    sha256 "b07b45cd8fde29d8b32b5285e177a12e4923c4dc8aff1bb8a31044be71704c50" => :mavericks
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

    ENV.universal_binary if build.universal?

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








