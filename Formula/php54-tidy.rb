require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tidy < AbstractPhp54Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "40e194f47378610c2dee43e3af220e31aa5a4eed8aee30004d672b7083d6cdd8" => :yosemite
    sha256 "d53c1fd5377e35b390c42e77183de22bb224996da12daffbbbe9272ede94a35d" => :mavericks
    sha256 "214810e29f75fce39c4bb084dcfc1e3085a0aa4f61b72db9339ed2d2a726d965" => :mountain_lion
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
