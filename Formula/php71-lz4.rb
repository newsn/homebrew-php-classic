require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Lz4 < AbstractPhp71Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.3.tar.gz"
  sha256 "f484c8229b3c5af1385ce11e4b37999702757bad9bdb2eab8bfe48fa3f159904"
  head "https://github.com/kjdev/php-ext-lz4.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c82532bc7bd0ce89963e67cf514e742d1b6c91a02d6163c75e665f7085d04d26" => :el_capitan
    sha256 "62a9b6e5590077735993f8a524807c7acfebc2844f7f0198d8ddd4af714f026c" => :yosemite
    sha256 "8078789ad18fdda51bcd637b82de0647b53bd4a453b1142ba8bc97ab187cf709" => :mavericks
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
