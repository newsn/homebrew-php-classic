require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Lz4 < AbstractPhp56Extension
  init
  desc "Extremely Fast Compression algorithm."
  homepage "https://cyan4973.github.io/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "92fd50e59e9a6d3ab2f909ca7f7cf28f03280ca4a6e493e0ae73d2c4f1cf27b7" => :el_capitan
    sha256 "a82b10615af07dadf6691e9cc1b25e72b950ccbc6af2c84b9af5e0aa272943a5" => :yosemite
    sha256 "093c5ce264a56f0ea2c40f300c926e8569ca3f457f75b6720d7728c913f19757" => :mavericks
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
