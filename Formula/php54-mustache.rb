require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mustache < AbstractPhp54Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "6013e704973cf3286d25282343382fa10ea9293a5e0968af69f1ccfe549045c7" => :sierra
    sha256 "9ae29bc9a9325b24d1ecf753f089c7f1c93a447cc17ba0507728e988e307ff20" => :el_capitan
    sha256 "82e03869b9d78e0e30bde3b0e2d8d326e8d8a40e090d09181205eb306b61a5ee" => :yosemite
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
