require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Swoole < AbstractPhp55Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ebce64fb8238e342dd13a727779921b5b6b258eeb8a8f03a60f0c0582cd4f0e" => :sierra
    sha256 "12c1123d47d9db547dd3d536b9c1212913d8e38556ee3c9b212922766c1f6991" => :el_capitan
    sha256 "dbca0d7a70a45dab34d757c82e1ae9d84e82bdca2f502d5164f0397b13b591b7" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
