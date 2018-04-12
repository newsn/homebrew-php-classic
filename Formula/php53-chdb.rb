require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Chdb < AbstractPhp53Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    rebuild 1
    sha256 "de4b513b84aa7c5793a6e167bcd01f535a57b8b506a115c6311e5cfd34bab921" => :el_capitan
    sha256 "9994cb01c84320bea24c1457ce8dd2b43093e134a41652af745e7d6d8486c5f4" => :yosemite
    sha256 "c751d99e81c8635dee9a77b60ac9f7d8cc4ee22136e9cf1b96ede2735e70988f" => :mavericks
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
