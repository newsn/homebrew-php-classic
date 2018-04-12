require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Swoole < AbstractPhp56Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/1.8.11-stable.tar.gz"
  version "1.8.11-stable"
  sha256 "cf2d9ba2c85f29c4a9f5e963878db27fdf552be7a05ca1709b6ad6f294e12b8e"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3f142c6ce934270eeabb10e82291ff808b681bec89de8fe6923c33364b3f1a1d" => :sierra
    sha256 "c5818e6eaeb761adfd5d791d8064d71a8a5bd3a04a139bbe18b9650f040db619" => :el_capitan
    sha256 "a671afb7ecd8c62735fc65f5686bc817858ad946bd0a0aaf3aa85328c6aea0e6" => :yosemite
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
