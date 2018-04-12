require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Magickwand < AbstractPhp56Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"
  revision 2

  bottle do
    sha256 "04b7215ef20f2c06c10f574c2966abbe293bdeba8d87ab4168587eba400261e2" => :high_sierra
    sha256 "22ef39aa3008d6d56a45a38cf702a0630574a4db4aedd2f61bb116e051fe3626" => :sierra
    sha256 "26aa44993d0c3c95e6fcb13f11423baff10682ab1765eefb8ed32ce2a74abc86" => :el_capitan
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
