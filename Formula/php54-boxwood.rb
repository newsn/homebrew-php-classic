require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Boxwood < AbstractPhp54Extension
  init
  desc "PHP extension for fast replacement of multiple words in a piece of text"
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "3db0c2999944babf6b4f1364b0682cf5896ba6650e3b3df0f2f042caade82e35" => :el_capitan
    sha256 "0a3025f8e468b86272d042fb7b6e42fc1861d89b669a966c7fb36535d1d70cdb" => :yosemite
    sha256 "33f9250ac06cb11bb2eecd81386dcbaaa0a3cc0a59fca81fdebc198263ddc34e" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig

    system "make"
    prefix.install "modules/boxwood.so"
    write_config_file if build.with? "config-file"
  end
end
