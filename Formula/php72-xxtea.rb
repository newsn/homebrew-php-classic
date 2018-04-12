require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xxtea < AbstractPhp72Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "cf5ac3083d4ed37052190bf55d8ef5d7293dc79dca27e982f6de8659e6e1af35" => :high_sierra
    sha256 "5fe41c8cd4e5e53c0e1d14b58b45a34bc16f2d1e1d078b143318199b9d83a1d0" => :sierra
    sha256 "373b21da39672da0604b7c88e34d5828736ef6beb30cc0fd18562e529ab4b2a4" => :el_capitan
  end

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end
