require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 6

  bottle do
    sha256 "792df9b98b2adc4f8a14f761adf04cb3901a4e25551b6fef03a90cfcc22a0138" => :high_sierra
    sha256 "bf7105cbcb50bce0ef65b5d98d8598c1a12641ac32af35f978c13c7cc271d27e" => :sierra
    sha256 "25d0d7591456239190b27a06a7a81b9db5a5b5141aba83e245605dd90b98d466" => :el_capitan
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
