require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Binpack < AbstractPhp55Extension
  init
  desc "The php implementation for BINPACK"
  homepage "https://pecl.php.net/package/binpack"
  url "https://pecl.php.net/get/binpack-1.0.1.tgz"
  sha256 "70617a721df4f8c52b5b1b214c11e464f8c36915cc19a850f24fed500c61b297"
  head "http://binpack.liaohuqiu.net"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "40d884acca75ad6030ef77ccf799ec8027ad27804b44a27854edfdf3ddafdfc5" => :el_capitan
    sha256 "ada6f1effe572f14441656e6da4f2aa2e5abc5a8f1ce97f4a5a5b3b2bce7657d" => :yosemite
    sha256 "bd1b06aada86a7368938ae16954a0fb96340ee8cd96ef3b0b8879dbc6a2c7c20" => :mavericks
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
