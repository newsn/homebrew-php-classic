require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54PdoDblib < AbstractPhp54Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 1
    sha256 "f11bba0a536476a06b805da414e2e99928b0f9295c3d73cf95ec718efd54fdf2" => :yosemite
    sha256 "4219b7dc94781536227b93b71eb808f6462a6c30f62ac9b8b7c45eacb0162f5a" => :mavericks
    sha256 "cc0b5e8678451f4f3e5d5fefa89d74113fe4c2af1c61406fb69c0f39f6ccd719" => :mountain_lion
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
