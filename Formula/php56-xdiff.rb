require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdiff < AbstractPhp56Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-1.5.2.tgz"
  sha256 "ebe72b887fcd2296f1e4032d476a8a463803ccfb0b34b403be8433daf3cfd81d"

  bottle do
    cellar :any
    sha256 "fd916fa5d1e7c5ad1f937096dcdff54d1e4bffcc16c0e0fe187ff130ad3e7aa2" => :high_sierra
    sha256 "211de1cbe0303618cb18a02bb0a24d2a53f316b37965fd4559f305ac4ff715be" => :sierra
    sha256 "f9d0d431af3fdcd95e747b18c4dce97e3f8593fd99c52977a909fbff439ea0d0" => :el_capitan
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
