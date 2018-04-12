require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mecab < AbstractPhp55Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    rebuild 1
    sha256 "3706f72fb90857a2d74cba1980b5098adf60283f30b13b6cfcd772397cacd756" => :el_capitan
    sha256 "7448e3eaa6a6a543192106bc411f6ecaf8a0e39b1d9955a8369f9927d6388836" => :yosemite
    sha256 "b67d78447f01056948824f2e489b160d9dc64d35feab01f0288c478673a00897" => :mavericks
  end

  depends_on "mecab"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-mecab=#{HOMEBREW_PREFIX}/opt/mecab",
                          phpconfig
    system "make"
    prefix.install "modules/mecab.so"
    write_config_file if build.with? "config-file"
  end
end
