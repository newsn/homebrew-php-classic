require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 18

  bottle do
    sha256 "e173de616ad0fbf0fa344b505c66bf0a38032d7c0aba27fd7561871d81c72c16" => :high_sierra
    sha256 "e61dd18f0687dc202f6b123e801f360dd9b9c9432c1203851b2c98a8a100322e" => :sierra
    sha256 "50dab3b35ee60308304fec00d255c099d650d27911664887a076d95f4b53dc9c" => :el_capitan
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
