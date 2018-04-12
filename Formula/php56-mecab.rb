require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mecab < AbstractPhp56Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    rebuild 1
    sha256 "df7be0ed6da1da8f27bf0afa2b08fa4e442debef2ad38a3d528a8d09de3d4f2b" => :el_capitan
    sha256 "8c6d2a7405452713b58adf8c5667bc56578d689e6b25c4b06ed7e04a2b69b8a6" => :yosemite
    sha256 "f82091ab7e3a667b8a4ecff880fb32dd547450af159a5620df5a30981d3381eb" => :mavericks
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
