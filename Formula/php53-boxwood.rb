require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Boxwood < AbstractPhp53Extension
  init
  desc "PHP extension for fast replacement of multiple words in a piece of text"
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "380898d4b5f9fbea739ea1ec864422102362bbcfc94300d1b8139309be95ffe1" => :el_capitan
    sha256 "9457a049e79c79602eafc970b6f33fdbe185ec24237363817bb6652ad9504fc2" => :yosemite
    sha256 "29f37157d407f92b5418b9fa752efd8ed68d243b0707201d726a81a6e5b52fe2" => :mavericks
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
