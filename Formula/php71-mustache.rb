require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mustache < AbstractPhp71Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "4fc8b361ffd7d166a3413e67a8668e2353e307c9756324b00418eb894a775b2c" => :el_capitan
    sha256 "7fdcc4299ffb3da1a54ede24e1b2de6954bbc3b728c1b35eb876056d58792919" => :yosemite
    sha256 "8175573405b830bbbeec8052ef16cc4413c0cd70f70e72c83a1f9e7ca660f641" => :mavericks
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
