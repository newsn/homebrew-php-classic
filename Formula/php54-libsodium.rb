require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libsodium < AbstractPhp54Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz"
  sha256 "537944529e7c591e4bd6c73f37e926e538e8ff1f6384747c301436fb78269b9c"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "1061c578396cb39f1f342e41835a46d3753fd7cc23b12af61523243bfb4b2b8c" => :el_capitan
    sha256 "955a7465b51940fafcdf37004f970c4c1db448468a560d4e998f8781e67166ef" => :yosemite
    sha256 "85cddcbb72a64797b079fa1ab844a4a5f69625e23c259a41fa102b2d6030aefb" => :mavericks
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
