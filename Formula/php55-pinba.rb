require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pinba < AbstractPhp55Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "b7143f06db00bf086fba83e972b7cd33f6ed444e6d5ca906a7f7a96b8d1774ee" => :el_capitan
    sha256 "394bf6532ae982ca51564c6a10ee5701354506474884fb6016a1e4ef7129d770" => :yosemite
    sha256 "ad4138905234ab5e2aecbe8ce80027876e77fdeff2bb5c9339c162264b4544c1" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pinba.so"

    write_config_file if build.with? "config-file"
  end
end
