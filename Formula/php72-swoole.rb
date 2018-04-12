require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Swoole < AbstractPhp72Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/v2.0.7.tar.gz"
  sha256 "d8370a5f959f2d4082f5b2cec2e3a5b294dd3d7f586a5c7a19e3d154b48c699b"
  head "https://github.com/swoole/swoole-src.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "eb3a57d8a322d2865376d95b9118ec5d095cba53599f65dc74205ee8adc53391" => :high_sierra
    sha256 "bfbc73391c6aa1224509efcb562d368083ac7174611209f05a5fd006e93ed122" => :sierra
    sha256 "517abae2f9eae2a0e40da456b50a689fea4a9321f3b1189500c53499b0a45426" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-coroutine", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
