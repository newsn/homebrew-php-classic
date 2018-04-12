require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Magickwand < AbstractPhp55Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"
  revision 2

  bottle do
    sha256 "bd31783b8323dbc1956f04854c481c36690214283f9d83869f661badbb13e391" => :high_sierra
    sha256 "91c11ff9379cfba86b3dc0fecfdc24cd2cbc963b06780535d1e39b6f788b8d36" => :sierra
    sha256 "19d7d71f178eb6c23396b9389130d42d74a7fdb95389b4b644200dfabf9b6728" => :el_capitan
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
