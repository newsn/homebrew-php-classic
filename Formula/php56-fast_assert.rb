require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56FastAssert < AbstractPhp56Extension
  init
  desc "Provides a nice way of making Assertions in php."
  homepage "https://github.com/box/fast_assert"
  url "https://github.com/box/fast_assert/archive/v0.1.1.tar.gz"
  sha256 "f8bdd0dc3c6a76e492047016a62aaf0cfe3d3394b4495c3e4cfee75d74ef5e77"
  head "https://github.com/box/fast_assert.git"

  def extension
    "fast_assert"
  end

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-fast_assert"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"

    prefix.install ["modules/fast_assert.so"]
    write_config_file if build.with? "config-file"
  end
end
