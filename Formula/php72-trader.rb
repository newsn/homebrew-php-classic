require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Trader < AbstractPhp72Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "f7dbe651fc4b062c89d7cab13e74e4384fd0921526f19e092f4c502b8e408aeb" => :high_sierra
    sha256 "587e1c4e53db43cf8ce5f18cfcabf7e9fe7f608680003e3cd55d8c62cc708aa8" => :sierra
    sha256 "5a85b0249e701c46293d3268463aa1dcdb417104f0da5acf67e80ce74ed2bb46" => :el_capitan
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
