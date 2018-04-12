require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    rebuild 10
    sha256 "35dad57336c9969e2ae927ae60af0ba73848c66f8892b62e5c9677ac8a68523f" => :el_capitan
    sha256 "f67058a3b30e72e878f7939e3aaa37462cb4a717fdb86442e38595b6fd3408e4" => :yosemite
    sha256 "79315c2dfef2718ba22b0986f507837645f117664e4c00f70d74a6af98f952cd" => :mavericks
  end

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end








