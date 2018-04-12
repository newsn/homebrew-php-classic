require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Trader < AbstractPhp71Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5caff0e7e51b77c09be949e16681f24142b3eb40200ad9bc8457a5342b10bf8" => :high_sierra
    sha256 "e901ce8726bc7df98dab90d083db7d250f8969e97023e6ffa25fc9b008e98557" => :sierra
    sha256 "757759b55d1d9a8c29cdc7b8580e7760f313d4fce27f3240e8114203a8a5525c" => :el_capitan
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
