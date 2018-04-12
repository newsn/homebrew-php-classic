require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Chdb < AbstractPhp55Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    rebuild 1
    sha256 "d842d184ec4918c6b0b1601e78e8702bf10c1af9bcc856ccc90afe045f6fe99d" => :el_capitan
    sha256 "5873c57ce014984f72f75561f9f2113bd2c2f0d18d917dc3097b783426e17bda" => :yosemite
    sha256 "b826583683207d71db9342259614ec848a8774108e8de1e2caccb11f2508f171" => :mavericks
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
