require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Chdb < AbstractPhp54Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    rebuild 1
    sha256 "734e209e54c6f4fee86109620993d6789c2815b7334d7edd3c68d3ff35fcf103" => :el_capitan
    sha256 "7eb8db24f686df50b623ae0b90ea9a3871c12e5be851f99e95d739f7c9463cf8" => :yosemite
    sha256 "0411c23b7790d62c37a3fc1853831606dae12f9cbd5f7784d39da7af6a61bf0c" => :mavericks
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
