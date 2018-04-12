require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "9497dc25fc9002adba752db3e89754b84dee3ba70a802e47a5751d33b4ceeb4a" => :high_sierra
    sha256 "4b4fd6c9e4073f72c6ae68f52751894f365e9c0f10b2be7b0cc0a4b884f70616" => :sierra
    sha256 "06a2956d6db40a5e28adc2cdd5c6d747e1b9e7e5687fbcc1f44c8fc231b57946" => :el_capitan
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
