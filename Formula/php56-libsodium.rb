require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libsodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "b72ca95adc0312a6b5c07dde8498c18d41e7299c88016c77702a355c7aa3d250" => :el_capitan
    sha256 "bf6915e807c4f0e937e38ced15f101044f87bab531dbd76c6b9a991fcbad5130" => :yosemite
    sha256 "8479fce9fa1c01d47464fc69252f08e0bf4d3bc500fadbc98c5c6ac7917f2599" => :mavericks
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
