require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Crypto < AbstractPhp56Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "0c75966d75c3c8b98550283ba0a77f217dc4defc773584808df6f2e6ad016206" => :el_capitan
    sha256 "953a45f8262901909fbf40c2451976fdef5cceb5f4d856634c9c8c1de3d190ab" => :yosemite
    sha256 "0c9f5aa4cdc846d4cf74658c810d650610999adabbd1f16643307ed9ba74715f" => :mavericks
  end

  def install
    Dir.chdir "crypto-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-crypto"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/crypto.so"
    write_config_file if build.with? "config-file"
  end
end
