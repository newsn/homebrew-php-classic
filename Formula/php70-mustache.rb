require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mustache < AbstractPhp70Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.2.tar.gz"
  sha256 "5eb0a25d42532db98e2e9087e49db060369651b16ac1accd61415424a47561f7"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "51c33f3ea67ca3aeaea538b38b6bba033aabb505c39734d46aded3e2978e879d" => :sierra
    sha256 "27aa0d3606b08f51ddf4911300cd12fc2dc0b6312da21b059bb40a3f6987f7fa" => :el_capitan
    sha256 "4bb8f2d3c0f8531808a09c1c7649bcf3fcba47e621644f70659ddc822526ca38" => :yosemite
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
