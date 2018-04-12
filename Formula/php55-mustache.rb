require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mustache < AbstractPhp55Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "d290fdcc9998025e832bd751471deb92ebf0e5653f20bdbba4c8de222b078d9b" => :sierra
    sha256 "7be14c133842ceb32cc6997958ebf2b3545ad144c20e3dbe4b7146e220360bd4" => :el_capitan
    sha256 "b6bcbe936b7f750440f403ed6f6bdf3e456f24bec594c7d1b0fffd4245c44f8c" => :yosemite
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
