require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Geos < AbstractPhp71Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "f85a32e4653b0dd0df73e7ceb58462c47fd6bd988a673e4a2c4ed84d5982d666" => :sierra
    sha256 "5c13570c7ec084432068d0bb2fc273398031abcf7ed98af21b9009ff43cc2727" => :el_capitan
    sha256 "7aa66c5d40e25f218939b3972abfad6ca043b6f0085b1313614156dd77b7d4ec" => :yosemite
  end

  depends_on "geos"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geos=#{Formula["geos"].opt_prefix}"
    system "make"
    prefix.install "modules/geos.so"
    write_config_file if build.with? "config-file"
  end
end
