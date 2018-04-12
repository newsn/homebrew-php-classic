require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xxtea < AbstractPhp54Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7557f527b41a93031a56b7cbac589781a907d1d47dc10928f8a8f67506a4331a" => :el_capitan
    sha256 "ce33c9956be0d9ac3136de2e2104cfbaa297b2405ebd7134a88c494e6fd8ab72" => :yosemite
    sha256 "095a0bc01d381d9a325d52f40d5d15cae910888982b575c0368c331152d41a24" => :mavericks
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
