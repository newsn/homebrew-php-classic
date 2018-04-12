require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Magickwand < AbstractPhp54Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"
  revision 1

  bottle do
    sha256 "f8067cd262ea8f1207f74857db93d1e8ef4b89c261d182ccdea83ec4609d8028" => :sierra
    sha256 "14458049361284a5fc71b1476664c1b5e812089edf932ac623155fa1ba1725aa" => :el_capitan
    sha256 "920244d56899f9170e64a98406ec5cc8f670beeafb97f1e606b895745e0681a4" => :yosemite
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
