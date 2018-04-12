require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Boxwood < AbstractPhp56Extension
  init
  desc "PHP extension for fast replacement of multiple words in a piece of text"
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "996a8381bb7be03e9b2971c818d64d89fe21b43c05ae785c4a34eb67d83bbe0b" => :el_capitan
    sha256 "f65e6a006f1df5c54aeeebe268c1bee130ddf849da436e51cc6ab3292a4d8129" => :yosemite
    sha256 "233dc1c638d66551d6d2063a9ab30b564e1b87d91c1c2bcc977ec3884d86d89d" => :mavericks
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
