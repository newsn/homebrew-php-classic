require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "81120d7b6bed3f8ec2583ce87396da8f1e8803a6f76e1f1f77f64a76981fc26c" => :high_sierra
    sha256 "ec03a928a582596043e52852b355e2cac79af8e487a8948d6dc5be606b9562de" => :sierra
    sha256 "2c57f47a62bf4ca3182085ab17dd5a0a5d1cd386db2443a88b33a86c82b2a5c3" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php5/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
