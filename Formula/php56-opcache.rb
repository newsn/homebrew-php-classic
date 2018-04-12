require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "92aa3679122efabfa1166ac903d53d69c487153d98f3692ff3528ebbed5208f6" => :high_sierra
    sha256 "9a2a34aec59b14dd8f3b752b2433c0460d9530f0b3680e8a73b61dc46cf61365" => :sierra
    sha256 "1a528fb7239f4390683a3cba060b5948aeb79a8c03e6db080f4e19837c8900ad" => :el_capitan
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
