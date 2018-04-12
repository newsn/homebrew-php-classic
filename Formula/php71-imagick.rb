require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 6

  bottle do
    sha256 "79bd418f5c7b3b88a52cfbea6f85919bb566902afa776d971d052feefd4ac599" => :high_sierra
    sha256 "c164b04b8da8896c67ac2090b83c073fc7adfbc9cce731b9e017a8aa89290487" => :sierra
    sha256 "f29b7db081837f9ecdae549d80b0b6304a36355ca828de915fefa7951bbd2115" => :el_capitan
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
