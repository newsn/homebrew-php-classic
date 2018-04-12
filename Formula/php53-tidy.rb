require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Tidy < AbstractPhp53Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "c559c297923e954b37d9432edc27023aa207b99fd48c188fa3f1b13cf137e8f7" => :yosemite
    sha256 "8ed2458f95417c3bcb04a52c59e3039b227a785d147eeae6cebb20dd4b9c0a72" => :mavericks
    sha256 "fc703969db7426073895d5d3794e2c9d74926c0e452f94bad224c4c951bfe4b6" => :mountain_lion
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
