require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    cellar :any_skip_relocation
    sha256 "6bef033b0046d7992b961e96814f964f4bfa2a28af971154d453c490bf07796a" => :high_sierra
    sha256 "9b00dacd10ff3d19088d5023263a026ad64bb550e6d4722708f3539134d8526d" => :sierra
    sha256 "4a75ea13563948c788808ca1e2997f7ff2eb45d058f1599a0fc3171b111a044f" => :el_capitan
  end

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
