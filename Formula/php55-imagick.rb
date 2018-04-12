require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 6

  bottle do
    sha256 "6c330a112fb0e20369cad3c632729fece43cdcf75550bbe0879cb6d8ec07b4b6" => :high_sierra
    sha256 "f00e07b70851153f647aa05fd0a22ae479b92bb26a7df35a5aa76a93661164a7" => :sierra
    sha256 "b54c04f26c5bee951357e5ac73259676e2cab29ce8996dae41400e4c5838f835" => :el_capitan
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
