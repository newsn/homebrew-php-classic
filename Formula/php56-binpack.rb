require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Binpack < AbstractPhp56Extension
  init
  desc "The php implementation for BINPACK"
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "614b8038d442b265b90068c0a18c388b72d4d82f185eb49f1862bc0b1c429fca" => :el_capitan
    sha256 "4036c48e35262876a51c118127b70ba4a716b0e6d15a28353dbae07e15f952c2" => :yosemite
    sha256 "7253d711878444a91fc6e9e4f3b3f8b61ee23b8a80e4e3ca2b7b32b2d90da861" => :mavericks
  end

  def install
    Dir.chdir "binpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/binpack.so"
    write_config_file if build.with? "config-file"
  end
end
