require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pinba < AbstractPhp54Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "edd3960e226fafb3aca38bcf7fbeaf8d4ffaafbde2c901d5c30b54bae19db4f7" => :el_capitan
    sha256 "34a256ee169f3aa986f1396d9b641719ed89b4739392af287a6c94ccfddadd38" => :yosemite
    sha256 "0acd82842047d0055b18118e33312de40e6543fe09d41875a35720666e130e03" => :mavericks
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
