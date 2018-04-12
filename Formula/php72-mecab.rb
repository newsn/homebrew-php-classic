require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mecab < AbstractPhp72Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/rsky/php-mecab/archive/v0.6.0.tar.gz"
  sha256 "8ec57164dd208f700ca16853f07fb62f111e16b025ca1ab5d4100aaaa9aa7c58"
  head "https://github.com/rsky/php-mecab.git"
  revision 1

  bottle do
    sha256 "ee586c623f42194be1e594ee3cdcda4f398a23e55d2ef53f1ab3fe7ed4b0beb3" => :sierra
    sha256 "ff34cbcb408a88f17037a55bb098e5d8d437f33f25c5e3c8530312c8eb309507" => :el_capitan
    sha256 "3f6ebbed273a35e602b1230dd59187800c3ad0adf4da98441eb1ed20dc6e4815" => :yosemite
  end

  depends_on "mecab"

  def install
    Dir.chdir "mecab"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-mecab=#{HOMEBREW_PREFIX}/opt/mecab",
                          phpconfig
    system "make"
    prefix.install "modules/mecab.so"
    write_config_file if build.with? "config-file"
  end
end
