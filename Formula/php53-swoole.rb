require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ed913cd06271cb986528376ac5823227cd354630a13ca4ac08730adff310cc9" => :sierra
    sha256 "e5cdda67cc70a549ecce02d0c98f9106fddbe971e9f86131ccc137a4ad59ce0f" => :el_capitan
    sha256 "e96e752a3ad72404047b4aa7db89a93e37fc4206d4bf6d6621badeb5d4dd3bdf" => :yosemite
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
