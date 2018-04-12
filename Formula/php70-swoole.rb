require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Swoole < AbstractPhp70Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/v2.0.7.tar.gz"
  version "2.0.7-stable"
  sha256 "d8370a5f959f2d4082f5b2cec2e3a5b294dd3d7f586a5c7a19e3d154b48c699b"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "878b729e02e9fc873e715bf1868009af01d6c283deb6bfa869488e4de55b77b0" => :sierra
    sha256 "4ecea677a69895cd20e0cfe00db309b283e4aeb2b40976e3ce6d83b6f77db8b9" => :el_capitan
    sha256 "a08f4506ff3025f2827618db594678e198ed15b011fcad6cfa07d3892a8a6bd0" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-coroutine", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
