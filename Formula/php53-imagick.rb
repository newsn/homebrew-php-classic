require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  head "https://github.com/mkoppanen/imagick.git"
  revision 9

  bottle do
    sha256 "a852ca433ee1b4342f424086f454a3057abb8fbd871ec4cf6f0e563aa38ea984" => :sierra
    sha256 "d314ee2ea00dacd02a3891825f35b47dd07f5b5350743f5cc8040ff91ad543e4" => :el_capitan
    sha256 "5d52a909ddb679a5a79d1c925978c43dc63d4ed3b09823d4055f9350576aa044" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick@6"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick@6"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
