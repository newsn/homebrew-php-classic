require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geos < AbstractPhp55Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "446d3566caf90e99a2eabe848c00a9dd4fc50f14f0edc4d5eb7c2441ed483e81" => :sierra
    sha256 "5bf4d60d7d1e5ffeba429026cef02438317051825a2cee78525eefbdbd240c20" => :el_capitan
    sha256 "20316108df906ed8545a66415b94bf189c26908c3be0890059a243786709937d" => :yosemite
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
