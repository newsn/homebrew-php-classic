require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mecab < AbstractPhp54Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    rebuild 1
    sha256 "d7610f4ddfbd90c7d85e65e3920153dfe9c007b8f8429ff11f8eabdaad09f2ad" => :el_capitan
    sha256 "71eed6e3c32bc55dbdc765ce68c641ed41622a047159e3620ee795a49abf685b" => :yosemite
    sha256 "49c3cebcc521a1574480f2c8f9286a369a2c1aad8559e96fe63c069b7df60bb8" => :mavericks
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
