require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Trader < AbstractPhp56Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "8c0a7951352b910cf00b97dbb5d4c071c7206a27b1e7071f845378bed094f256" => :high_sierra
    sha256 "90697f8b042fd48d7402c7d65445c08ffe425628777a0f8259f69952a95eef97" => :sierra
    sha256 "25b1bb7b4cdbd508d67fe320cf855fa61be26cb72291885c8b60546661552eaf" => :el_capitan
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
