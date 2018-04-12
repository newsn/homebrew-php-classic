require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoDblib < AbstractPhp55Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 9
    sha256 "fac60cf7a0a52e747c421bcda3ab66b44a8bef0c58e846e2e413f81995a4d853" => :el_capitan
    sha256 "8d450b4033fb1168bd242fc275418c741db19c91f431eb5c98aa6c20ef705109" => :yosemite
    sha256 "0fbb2ff6cc644ccfe7cdba700f3d7cceb826fc6e9def0fa40ebb5ac3be64348c" => :mavericks
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








