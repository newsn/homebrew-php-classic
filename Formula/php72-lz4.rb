require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lz4 < AbstractPhp72Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.3.tar.gz"
  sha256 "f484c8229b3c5af1385ce11e4b37999702757bad9bdb2eab8bfe48fa3f159904"
  head "https://github.com/kjdev/php-ext-lz4.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "e0d59e7a80ed74a99d15a033dcce0320cdcadbf1b17046694082ed7488bc8d19" => :sierra
    sha256 "db7bdfcaa2531d84d23d420876f748696e87bbd9fd487ba8dc9f97c1498ce17a" => :el_capitan
    sha256 "0c0cc6eaee1878e8544dad66156cd5c259eb3073bd5326aa9c18748c91e5bf72" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
