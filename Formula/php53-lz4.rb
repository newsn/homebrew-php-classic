require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Lz4 < AbstractPhp53Extension
  init
  desc "Extremely Fast Compression algorithm."
  homepage "https://cyan4973.github.io/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8081ee48b5845e9c25a82836d114bf2e8397a2ff651c6c989b5936b18373f222" => :el_capitan
    sha256 "c1435548b7459cbce12e1f7c1181612ab8467f7f95e69942ecf956ae4f1fc2d9" => :yosemite
    sha256 "d1e7ebbe5088a90cf3a307755a4d58b38670cfcf8526c8b2b59ff43d0b719736" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
