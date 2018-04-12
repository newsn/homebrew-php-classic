require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Chdb < AbstractPhp56Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    rebuild 1
    sha256 "4bb63c263aa5c4e218f0122a35e0b872aae3e32bc606edde72f3889e0122594e" => :el_capitan
    sha256 "b1bd71946b09eb55338736159bbcbb1ce5d7fe2f1e867a1385fd8adbc399d8a8" => :yosemite
    sha256 "14713be651966e1fc861022c1c4f6a18efc370da7cdf91ec2a61349955f0c8e5" => :mavericks
  end

  head "https://github.com/lcastelli/chdb", :using => :git

  depends_on "libcmph"

  def install
    Dir.chdir "chdb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/chdb.so"
    write_config_file if build.with? "config-file"
  end
end
