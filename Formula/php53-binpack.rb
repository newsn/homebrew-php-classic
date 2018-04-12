require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Binpack < AbstractPhp53Extension
  init
  desc "The php implementation for BINPACK"
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "105464498adfc7b08c5d0f665584d0c9ef500cb0c7d0ac36c86983f87985a485" => :el_capitan
    sha256 "08bb26ec4c046fff95798dc6ae0c3ede7ef9be74010934820b45a4ccfdd6be39" => :yosemite
    sha256 "312cb0d6fa91c2306323ca63c7f7e12e8e8c2919fa05ed0fcf77debeba890efc" => :mavericks
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
