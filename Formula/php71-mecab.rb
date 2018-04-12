require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mecab < AbstractPhp71Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/rsky/php-mecab/archive/v0.6.0.tar.gz"
  sha256 "8ec57164dd208f700ca16853f07fb62f111e16b025ca1ab5d4100aaaa9aa7c58"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "46680cd8e6bf128a2639e2a10f03c7649f3b695d722e8271694d58baec33479a" => :el_capitan
    sha256 "299005d816e5a87857bb286683019b5a870a1ecbd32d8a5bead3dcda351117a3" => :yosemite
    sha256 "d228d16c12235840d1972eba0bf9ddb6eedd8f27f78f270130eb7ba4e97bd533" => :mavericks
  end

  depends_on "mecab"

  def install
    Dir.chdir "mecab"

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
