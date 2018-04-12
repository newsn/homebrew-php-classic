require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pinba < AbstractPhp53Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "f29fb1842a3deb57617b19454e955c657301bfd88037b23fb9e7e4791bfee9c9" => :el_capitan
    sha256 "129104122e418e48cca47347c0204ba3c71412e186fb13def72a93ffeece2414" => :yosemite
    sha256 "2b08fdeef7198ba639301ce90fdbecfcdac0a4709d8fd0fad207655f8710a507" => :mavericks
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
