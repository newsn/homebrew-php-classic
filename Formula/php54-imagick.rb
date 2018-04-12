require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 5

  bottle do
    sha256 "7611a5be62884fdd7118aff9eb2bd4ba5e06f36d9da2dc4da9fbbb7b1449a29c" => :high_sierra
    sha256 "ca89107ae587d0c7ec1625c1dbf7bf8d5028eff7080afc3b15788fcc05bdee07" => :sierra
    sha256 "d77247d16ca5a7239d47878d11e3369e2af95561ab67676bbcc2da04d80dc7c6" => :el_capitan
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
