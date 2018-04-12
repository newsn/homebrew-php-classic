require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Imagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "e29e0a41ba2e17ec8596f6364bf1a6755d7e54f5d1e7377ab16c797e7b2a9fd5" => :high_sierra
    sha256 "5d0661e6b056130cc8979e82adb9c5028731acaf4f42d722eb0ca6a57ccc7a6e" => :sierra
    sha256 "11f256110a9b09dffd6b64ab5b8c71f6a511961576dacfc75e68365a2e9f6b6d" => :el_capitan
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
