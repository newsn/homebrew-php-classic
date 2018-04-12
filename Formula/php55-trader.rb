require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Trader < AbstractPhp55Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "22abb7c7af97feadf48f1daf0b0f5c535ba430b22ebc0a7d6346e48bd340372d" => :high_sierra
    sha256 "8b0d0b69a6b9fbc74ec1236308ce46c2f7169285381b9b7162e5064698e65cf2" => :sierra
    sha256 "1fd70b02db0a2cffb992242c6f9dd190a62026fe18603da6c3b48d443fd18a1a" => :el_capitan
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
