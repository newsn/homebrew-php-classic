require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libsodium < AbstractPhp55Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "b1dd0916b4ef9f9567f3c528113310a2526615e40ff282d7152e7d6a5ce2da58" => :el_capitan
    sha256 "b0685f2b5609290784bd9ffb1c488c03eb7c08194cf50857389ecdd0114f0840" => :yosemite
    sha256 "edd7fab6cc0c13d59d5c60016210f70f5daf540978cb9edf9eb7b5f1eb035750" => :mavericks
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
