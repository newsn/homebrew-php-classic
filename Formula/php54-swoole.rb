require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Swoole < AbstractPhp54Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b6b577df243c1372e21037d87a29adb797520c546b90f5a197a10924836913c7" => :sierra
    sha256 "2fa3f94db9285a91b38a9146a343a34366968346181126b046140bf5dd21805a" => :el_capitan
    sha256 "e571e7056ff54e4eb6250feb7721f3a6425d12551f740dc5c6d84d223ce4ba1c" => :yosemite
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
