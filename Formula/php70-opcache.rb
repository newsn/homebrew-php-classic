require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19

  bottle do
    cellar :any_skip_relocation
    sha256 "d24e05ca58f7813de1475dbf1279faf8ea22882e835704e2159465c5df5f2263" => :high_sierra
    sha256 "fe6ae20c7079c1fc7fc03ebc1d68b6262bf5af313c719e806ee5034c2d3e243b" => :sierra
    sha256 "23a838e3237daf59824e7ebf7a85843f7875f99310adbc4647c1233c15a0d7b3" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
