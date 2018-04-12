require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    cellar :any
    sha256 "88b44c6ac4be874e41f130091bda262ae88188a934aad4805d8dc7581ad54d55" => :high_sierra
    sha256 "a05b2789fe40118f62d5505b8647582d3a9fd21d9fc162fb9c4a6846214dcb19" => :sierra
    sha256 "733dba92805cb77fac890850de753f3828825c7cb66cfce2662def9a96924dc0" => :el_capitan
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
