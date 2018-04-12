require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libsodium < AbstractPhp53Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "6b7b1476b12c808fa6bb9503d4103a561db38babc49474ad71ea197352f64fac" => :el_capitan
    sha256 "29ba8d57b6e1acd68bd52804962f6d04a7c6ce039cbeb76dcac738e179b9b9f1" => :yosemite
    sha256 "e07e15ca9d8e7dfea339d211d74a3c1c43bc9dd6c7d9bcab2836267978097dc4" => :mavericks
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
