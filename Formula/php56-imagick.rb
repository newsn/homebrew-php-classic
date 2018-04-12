require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 6

  bottle do
    sha256 "710e21a66ac868b5d424e9d6c87dc0b2d36b10cdd017d89d23e7061c694afe3a" => :high_sierra
    sha256 "a0ee950c4b0a4f02a6e2de1e291f7eb1a617d1cb0ea577eb92eec4870b4e1fd8" => :sierra
    sha256 "8e49882f5bd99065a74eb96716daf514f8bcd1286ebd277945c160ccb112da10" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
