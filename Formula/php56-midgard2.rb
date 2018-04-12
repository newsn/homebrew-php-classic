require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Midgard2 < AbstractPhp56Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    rebuild 1
    sha256 "014bad13e84ba188d0e9207a0f4446b31bdd35bc4e1c2cfd2b8dd2cd93f67535" => :el_capitan
    sha256 "5a1f7184677bf1a795b65e0d12f7a35ccc3f01c2d7e48937b5b4407e10799032" => :yosemite
    sha256 "e395e2c32a9ae0e1ab5b7be0387fefef2ad13754306f050416af3e7c1d6be525" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "midgard2"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file if build.with? "config-file"
  end
end
