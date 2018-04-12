require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xxtea < AbstractPhp70Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d55447262e0f3c91b04790dc7b8426de648130186b4027c8dfedc91b3b0fdaca" => :el_capitan
    sha256 "e02ab0cf3b4472b7bf000eda48b497db087f2a157b4d715ce829f5a3bd805cd1" => :yosemite
    sha256 "2c7e1d1a801a275c5ed3592cd4e203adce8bcfd19d29902d30659bcf1e795221" => :mavericks
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
