require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Crypto < AbstractPhp54Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "9f7afd1de74b158f3e3395d537be60daaf656283b8a739d5c3f2b9a0747c6e27" => :el_capitan
    sha256 "64230ab3ecd54cac8b7996f937ac5ff7ed7c2f7559ad27a81a22d6a288ec8f1a" => :yosemite
    sha256 "a964845e8dc2c85dc89d4f10c802fc66419c8865966b0fea2674d6ea01bc0f34" => :mavericks
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
