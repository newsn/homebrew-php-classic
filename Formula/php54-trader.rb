require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Trader < AbstractPhp54Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.4.0.tgz"
  sha256 "64400b2331cd843cd1bb684b5d02145ac6c00118565915fe592c6eee3c108784"

  bottle do
    cellar :any_skip_relocation
    sha256 "79b7fc20860a43135c5772638cd5f147d6ba74d8a008480a38074f25446bb82f" => :high_sierra
    sha256 "0ff944cbb765a3d5e5f653aa131984a1e8f4e9f9e067e3cc489ab9f5483409c0" => :sierra
    sha256 "cc58dc4be0fc7fff98cc9f4637ead9bac4166b96cbb20af71534af24d48d29ff" => :el_capitan
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
