require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Lz4 < AbstractPhp54Extension
  init
  desc "Extremely Fast Compression algorithm."
  homepage "https://cyan4973.github.io/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "359b282a83d03923cfb9480a891b91176140575fe644d193f38cb10c21be0685" => :el_capitan
    sha256 "f9da4785125e93a58d055108425a0d1c0c2b17781b6bbe2bddc319e713c69557" => :yosemite
    sha256 "533df8de828995dbfac6a4128712a0ee291fa52bfce2aefec392ddb367df480d" => :mavericks
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
