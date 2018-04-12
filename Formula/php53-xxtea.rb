require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xxtea < AbstractPhp53Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa9dd0b41fd9f220fef9630a4c058ea310d85640d2c1924729f9f216fa9f1473" => :el_capitan
    sha256 "8a66db92ae0a2b196879c5fd2d26989a1d0c3d52313a09681ac5e0288931dde6" => :yosemite
    sha256 "9418aace9305258bc897f0f3e2ad9be412b7af0d1e462887a23298f3b65dd1c2" => :mavericks
  end

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end
