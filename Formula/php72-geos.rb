require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Geos < AbstractPhp72Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "c69ab41a7be11e62864c0af225e510f3c3f6a8bf3c8697464da1a660fa100bba" => :high_sierra
    sha256 "1a1a49a8984e70d0c3c641e3e4b57b3a4832daba01307d79888a217ecdb6ed35" => :sierra
    sha256 "646c42669613088504472d85d65c851fa755500e802ff1e3434199b6d8706d1d" => :el_capitan
  end

  depends_on "geos"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geos=#{Formula["geos"].opt_prefix}"
    system "make"
    prefix.install "modules/geos.so"
    write_config_file if build.with? "config-file"
  end
end
