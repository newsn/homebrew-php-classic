require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mecab < AbstractPhp70Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/rsky/php-mecab/archive/v0.6.0.tar.gz"
  sha256 "8ec57164dd208f700ca16853f07fb62f111e16b025ca1ab5d4100aaaa9aa7c58"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "45b9fa2ae008caa06eae9ad14ad9bc339ed675473d9cfc4fbe7900bc8783ca36" => :el_capitan
    sha256 "1fa51ae37de43777994ae8cf5d1c7f83790567e5e0fb57088b7820366121c698" => :yosemite
    sha256 "0bf0217e03c7b58f94b78a7f081945537469cd35129c0bd8560b2d3eab837a51" => :mavericks
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
