require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54FastAssert < AbstractPhp54Extension
  init
  desc "Provides a nice way of making Assertions in php."
  homepage "https://github.com/box/fast_assert"
  url "https://github.com/box/fast_assert/archive/v0.1.1.tar.gz"
  sha256 "f8bdd0dc3c6a76e492047016a62aaf0cfe3d3394b4495c3e4cfee75d74ef5e77"
  head "https://github.com/box/fast_assert.git"

  bottle do
    sha256 "b85763547332b948f507badd550977a73da1f2d5ff3fdf1196c04c41f37395a9" => :yosemite
    sha256 "2b1d6fd592bff2843f15117d309c046f61a392b8a4e0127d726245e3abf5a676" => :mavericks
    sha256 "92d635a5350d749b57c1c7bdf91ea43a9c80edd4c584d8f877d91a7ea655d5e6" => :mountain_lion
  end

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
