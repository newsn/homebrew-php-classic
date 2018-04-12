require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pinba < AbstractPhp56Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "3c739476d545646927dc1fcd4d7741c06179d7d124eb7d52d55d7d273602722d" => :el_capitan
    sha256 "91b9a0b366349a3ffdae70a9bcd9f46b2ff74e33b8f670635e08729a30ecf167" => :yosemite
    sha256 "e0947f5a19998024c426873ced9629ee89fed0c020ab88a0361ca88fc2fdf68e" => :mavericks
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
