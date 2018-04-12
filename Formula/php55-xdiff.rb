require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdiff < AbstractPhp55Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-1.5.2.tgz"
  sha256 "ebe72b887fcd2296f1e4032d476a8a463803ccfb0b34b403be8433daf3cfd81d"

  bottle do
    cellar :any
    sha256 "b7e4c5af3302d7e4af29a23dc46a02d1c9df0001065128f945873b051775fab0" => :high_sierra
    sha256 "ab1f0ba63a9a4f2fbc5cc40269125d8fce28c46d3cfb1f3bb517d5fc91783d14" => :sierra
    sha256 "66472973cf8e8302f880e741c32b7036d32b545aa655fe877271c5d8312a45b1" => :el_capitan
  end

  depends_on "libxdiff"

  def install
    Dir.chdir "xdiff-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xdiff.so"
    write_config_file if build.with? "config-file"
  end
end
