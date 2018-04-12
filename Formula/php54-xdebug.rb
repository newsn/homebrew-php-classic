require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.1.tgz"
  sha256 "23c8786e0f5aae67b1e5035972bfff282710fb84c483887cebceb8ef5bbdf8ef"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d550e4b0133303aee9805982db0bd2a1e15d48145b7224bef739ccefbdab829" => :el_capitan
    sha256 "d2e83080a252dc0e041a00047b0a8043289addf6db6f9b930eeb5d6386d37bc4" => :yosemite
    sha256 "e43a1c9930107e909c813dbb6fd61ece52088b89a3e415fc26f8302c64c8d6d1" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
