require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mustache < AbstractPhp72Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "cba60d8866e146a2056d9fb33e56ed76df6d57bf7f672aa6dc4e822d1b9eaa3b" => :high_sierra
    sha256 "6e5b21ed573742ea2edda6fcebda236dcf60a5fb269175560ae81ccc951fa774" => :sierra
    sha256 "bb63fe230e6fe7d0b6d834e928e53c6b59bff0c4fb3fbbd80e9e3c1f1c3a9be7" => :el_capitan
  end

  depends_on "libmustache"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end
end
