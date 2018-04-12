require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Phalcon < AbstractPhp71Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8b3a70d5fc33c6905c6e96f9d81595fcb9f838214923e3828c910817bf6a986d" => :high_sierra
    sha256 "5e212622af709b75ce892de2ba1e430669602e003e9c5f6dbaa6fc15fa541fb8" => :sierra
    sha256 "9d3434942f365878c9993bec7d3e21da524c7af01ab06c5275dbd5c6f38bbe06" => :el_capitan
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
