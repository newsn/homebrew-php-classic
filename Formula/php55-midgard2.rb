require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Midgard2 < AbstractPhp55Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    rebuild 1
    sha256 "8bde8582101577a3e68cae01277730077daae58c10aa458db87d85cdec9b0f20" => :el_capitan
    sha256 "6fa256904573f73dfd1abf72ae999bbff99f8fdb47b998327ee74001a6cdf6f9" => :yosemite
    sha256 "b2dfbd5a6cc89d44705493cbb9db716de3cf9c842a0f18544f4468dcd5143def" => :mavericks
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
