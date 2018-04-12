require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Geos < AbstractPhp53Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "63dc2211af10df6c7dc47d52d880c14004206b8030968e60642d9a1377609da9" => :sierra
    sha256 "0a5188c1afba41c90bc4025c439e659b2e74c4cb426ac5057b7f70454e48420c" => :el_capitan
    sha256 "224ee7269cb4aa9b161af900769cbdce767be92aebaff81386e7da113642223c" => :yosemite
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
