require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geos < AbstractPhp54Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "91e169e68843e498453b1d4705dfaa0e10a94412ea08df525c22a7e1777eb8d3" => :sierra
    sha256 "8ea7da88af5855d880aab4f66c79647258d13be93b9dd25ca824abfd129623a3" => :el_capitan
    sha256 "0eb4257d6055b19eb0b189e47f1908746b600f17265af2bd79ef5fb9eab5c882" => :yosemite
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
