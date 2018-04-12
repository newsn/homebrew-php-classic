require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mecab < AbstractPhp53Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    rebuild 1
    sha256 "4c3dcda4684724f018210a990a379db84efeff4d6c0d8b3f766aacd3456d9adb" => :el_capitan
    sha256 "bb5cff0cbca74abd83cc22b20ecd96ef8b0def8045075ffef8da0aaf882dce6c" => :yosemite
    sha256 "8158d871d832acb0ec00752422a6b45f86eca242a3e89175ad15d20b54b3d62a" => :mavericks
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
