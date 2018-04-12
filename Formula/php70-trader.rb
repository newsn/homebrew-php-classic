require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Trader < AbstractPhp70Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "30e914af51fb6d3f132deb6c7cd46e6ba7baa37587929d2858e0f3ba638d5ca5" => :high_sierra
    sha256 "0d8e67385613fc928d2887fbf8f7d4fa56e01bf3b89f3a93de53f302520e1a1c" => :sierra
    sha256 "8a1efdfa7dfc5a3979d9d33fa1512d3582bb68ef82dc90145c91cb3369b4dcf2" => :el_capitan
  end

  depends_on "ta-lib"
  depends_on "libtool" => :run

  def install
    Dir.chdir "trader-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/trader.so"
    write_config_file if build.with? "config-file"
  end
end
