require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 18

  bottle do
    cellar :any_skip_relocation
    sha256 "3394ddc40c7e858936223a49e69d971b62930de65fbc478794b99812e3f72cdd" => :high_sierra
    sha256 "5b22e31a7ba6d37c63e5da2bc4e5abecee0a64ac7ce56168bff19568b28ae626" => :sierra
    sha256 "bf50f6b900721b50dcf018307b15e943b9bdc49d3eb3b228af1dde109b714cef" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
