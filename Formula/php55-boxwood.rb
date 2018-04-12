require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Boxwood < AbstractPhp55Extension
  init
  desc "PHP extension for fast replacement of multiple words in a piece of text"
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "c01298842370e2e01ef4f84a790d789aeff1f6c75819d2b644995f45a06a8b7f" => :el_capitan
    sha256 "9a8e42022fd6edbbb2857c0477936d6edc29b30edcd6b37f774f18e3b31d3d45" => :yosemite
    sha256 "faf26d44bc67eb9f0aa1e33b0d4719d8e203e749b0f64cbe5f23012ee8ad556d" => :mavericks
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
