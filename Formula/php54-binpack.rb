require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Binpack < AbstractPhp54Extension
  init
  desc "The php implementation for BINPACK"
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "bf67b87d114a4b3bc5a2ed06a5020d1bbb9afbdea37f84bb678083e3551c5d1c" => :el_capitan
    sha256 "2bce9f13b36290870a0ed44608a7dd93f7223b8f9fa63f46211f8a071d2d7bcb" => :yosemite
    sha256 "c484eb30fd0b3d949e8a75fad05fc9f3190a129eea02f4ab3bf7165a40dcf462" => :mavericks
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
