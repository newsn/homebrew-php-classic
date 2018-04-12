require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Phalcon < AbstractPhp72Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "168d9bf65b4efbecb6346e7cec60318225c3db09f4ec389e31fed2bef709bb46" => :high_sierra
    sha256 "952104aab811c4b2cc740ed8800a6df158d5515cff4b62a0ecf34651e2a77213" => :sierra
    sha256 "cf1fc06497db9b3c941e2fd9ba42b0d6a16e5915891bea8b4c5f88fb6cdd7b8c" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
