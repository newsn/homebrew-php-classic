require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    rebuild 10
    sha256 "e3dbacfaaa21e7e51a25063f96137e50c44a6056a724c1d2b7d2b1d6e0ab7b64" => :el_capitan
    sha256 "b0851a1bf89cf159e31b6c0e8f0905d5aa1bc69e5bec4f6c5288bc2a77940e76" => :yosemite
    sha256 "456b459e40b400e1a6cc20285059eba5090dca1756d25d99d932454a10748e7f" => :mavericks
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








