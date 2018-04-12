require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Magickwand < AbstractPhp53Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"

  bottle do
    rebuild 1
    sha256 "93866fa193181ceb916a55297d11ee9e4a93ec34746eb4662687b1340b407145" => :sierra
    sha256 "7bf6cd43c80b0c736b659ed824aec1fc9f5eacb4297ff76e31c7afbcff6b3afb" => :el_capitan
    sha256 "93b3cdffa9d8bccdce95ea65ac900bb916c2d6ebcee84fada9b594d5f84cf849" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick@6"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-magickwand=#{Formula["imagemagick@6"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/magickwand.so"
    write_config_file if build.with? "config-file"
  end
end
