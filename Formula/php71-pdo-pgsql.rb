require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 20

  bottle do
    cellar :any
    sha256 "0f2ff2fb601e67a047d551d6393d4e4ae9ce0a61f8fca9ffb075984dfae4698a" => :high_sierra
    sha256 "71ad0e26d3b63d83ff62e6cf1e84b62cf7cc4618a06865ea418172b96693775a" => :sierra
    sha256 "732276da2a99adde0d29c92946e469a788d6cab2259ef16aff91c01ceaef91f2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
