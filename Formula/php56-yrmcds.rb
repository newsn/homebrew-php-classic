require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yrmcds < AbstractPhp56Extension
  init
  desc "Memcached/yrmcds client extension for PHP5"
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.4.tar.gz"
  sha256 "b509631c57d60d9003954164756448454f8a09e789dc67ce531363c6c08bc273"
  head "https://github.com/cybozu/php-yrmcds.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bcde26120936531102bddfb3ff4ff8ce4df858d3c356e8007490f15a0c391d52" => :el_capitan
    sha256 "1e1c0185afac6502165e3816d4a607ed2477cc93ab49ee4a963981de8fd05a1d" => :yosemite
    sha256 "c6fcf6d8068ac9152867181088dff36a7d7a35215b09313e21f37c07593bec9b" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/yrmcds.so"
    write_config_file if build.with? "config-file"
  end
end
