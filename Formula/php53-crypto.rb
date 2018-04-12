require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Crypto < AbstractPhp53Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7cc2580887d8007b8523583f7879a56717cab611c627441dbc65e8269dc2cdda" => :el_capitan
    sha256 "d6867c7f2505cd55d162d5744f84db39c7b1827650a4baf4550bf5332c84e066" => :yosemite
    sha256 "13d2c52fe034fdc618f4e9b9ff7c43d017bb18b47ff0fb49d602b954b00494f8" => :mavericks
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
