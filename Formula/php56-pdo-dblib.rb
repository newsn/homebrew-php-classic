require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "9e053a4f22020ca1e903dcbd90f499cb8b8ce90fc760a255a5859f27aad2a139" => :high_sierra
    sha256 "2cc85fb8577c55ebffb7cb9c724bfd5b9a107a2a30c4c549cb76b9120edfec6a" => :sierra
    sha256 "79e2f3133149e0c5a72754b374d838366e54c9d1510ae6d836b2fa09fac76cf4" => :el_capitan
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
