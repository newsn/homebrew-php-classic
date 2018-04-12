require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Crypto < AbstractPhp55Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b60d15fe9e086542973f4e3c4bacb8a04c5fd67923a2ab4c2ac9ccfee09edd07" => :el_capitan
    sha256 "2cd02c5a3746316546243b9e9d8686fbdc8d6ff81c24d977aa67c194f6141a7a" => :yosemite
    sha256 "78c413bf028eabc5b242a739c28cb280197061c7caec6e6ad7a825afb9ef0bc8" => :mavericks
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
