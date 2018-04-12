require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pcntl < AbstractPhp54Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "ff2775f23eea9e9a62197a3d89e92aeb2878578bb1220cacf73d0c1a8c68b807" => :el_capitan
    sha256 "d53497fb0b57c02740d8f7a7f68bf01d5a6d2f0146a4f86cf55b797eb1bfe30a" => :yosemite
    sha256 "b51b05dfb8b77181c7172796f7e2fd556ce7972b484d2d28b912c97045f46d1c" => :mavericks
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
