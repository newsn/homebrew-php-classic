require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c2f46a604986b0912feb9fd5ed776ce2754d4a227dfcf754515a4a24b8f9a5c7" => :high_sierra
    sha256 "f6815a68bd548c83a6a0b2103549e20b2f8628576be0cd31e2594d7ecdd7a3c9" => :sierra
    sha256 "8314d81d62d85381d51f9dc8a3b24afdc476cdbf950f9034edc674b7ff6e0d03" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
