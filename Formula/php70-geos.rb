require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Geos < AbstractPhp70Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "35a7c2599f5f502811271daff5d566978e4bffee30b74f5c35625d5a39ed187c" => :sierra
    sha256 "9e1666c4b5bdbec1f69a8079aff7e3c3d45aaccf078893dd531c3ed430e86064" => :el_capitan
    sha256 "3bebd634b7b3ab21dac50521f6bee339a64196c716ee23a249b4eb2d2bb0c67f" => :yosemite
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
