require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geos < AbstractPhp56Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "89dc20aa9a176da917346a3b1b29723bf42d284d4da09f84638cd18b6c23840c" => :sierra
    sha256 "a13f8b368bc9f7e3a8f1956cc3d3d821f93912b2243828e8a5793c4943f31f1b" => :el_capitan
    sha256 "cd733b2387e7a63ff2297ef9b79af2775e2048ec415db2e129734aae18ec331a" => :yosemite
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
