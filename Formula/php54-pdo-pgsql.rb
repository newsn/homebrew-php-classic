require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoPgsql < AbstractPhp54Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    rebuild 2
    sha256 "3a5673427e05910ca3ce708158ce8b0bdc7348e478901ed8fe207bce55d122a4" => :el_capitan
    sha256 "4e610bf5b7fc0de8e0037d9d4c4699c8becc1750a1904f77a75111db25cbc78d" => :yosemite
    sha256 "ba97ff08039f33d9a9d0b2f79e53e0305d17b303b413704f2f4520f9f92c6802" => :mavericks
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
