require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 18

  bottle do
    cellar :any
    sha256 "b1527659202cd2a1661ae5dc297b969db67b00a1d26840f206f0b978a8e6e4a0" => :high_sierra
    sha256 "1d11c0223cb6019d3d611cda83fd00ed0d5c954bc37eb928cd86bc1ad748808f" => :sierra
    sha256 "1effaa8b4689d9e1b95136dfd20ee2757050cdbae8d944e87099654e8e6064ce" => :el_capitan
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
