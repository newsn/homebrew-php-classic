require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Hprose < AbstractPhp72Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "63d5811e87409be466bbd43e173576d546aba055c67b4d97ce3a60108e93b610" => :high_sierra
    sha256 "9d0b0e6fe9ae09feeede926f54610c1d9abbf770834cb9d996fe568e459bab86" => :sierra
    sha256 "889e9b65de2f524222283ba184b1d97ee6d8699aadfe32a8cd8ec11f0010e1bc" => :el_capitan
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
