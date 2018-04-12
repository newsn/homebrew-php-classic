require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mustache < AbstractPhp56Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "f7431eb4117f1bf78de60898946480ddd9de24ef6cc033368c20969e8d7a96e5" => :sierra
    sha256 "aafd3a0f1a13dd58641760dfd9ebcf3e75796e5768e62fdf6ae5f8e4ae0e036c" => :el_capitan
    sha256 "4fad2333071946f6ec77d1c6e24d4ca2da023d622b98de54987a66ff5485a1d2" => :yosemite
  end

  depends_on "libmustache"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end
end
