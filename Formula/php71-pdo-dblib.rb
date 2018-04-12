require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 20

  bottle do
    sha256 "ec6711e80d147fbcf86f38ff947526272931ff9811ce4ebbe53b0d06c096ee8b" => :high_sierra
    sha256 "b0b08e8bc7542929baf4444d02ecc161c492bc11fc2fab5c7d8df058e761d4c1" => :sierra
    sha256 "4b10ea5b404836c617f5182484beff61d0078ceeec7cccd2d65ab7431ace9ff3" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
