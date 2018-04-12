require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Opcache < AbstractPhp55Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    rebuild 11
    sha256 "c792f151c8ebc6cc29042cb6056180258999e19708603e007e8a10c2a1915aff" => :sierra
    sha256 "dbf87c1974bb4586f43e9fb3a38397a0362278adc69a834fae47e28aac09d2d0" => :el_capitan
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
